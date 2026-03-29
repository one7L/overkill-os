# OverkillOS -- Tauri Desktop Application Product Plan

## Status: Future Phase (post-template stabilization)

This document is the detailed product plan for shipping OverkillOS as a native desktop application using [Tauri](https://github.com/tauri-apps/tauri). The file-based template (`init.sh` + markdown) remains the personal tool and reference implementation. The Tauri app is the commercial product.

---

## Why Tauri

| Concern | SaaS (web app) | Tauri (desktop app) |
|---------|----------------|---------------------|
| Where brain lives | Remote server | User's machine (same as current template) |
| Internet required | Always | Only for license activation |
| Latency to IDE | Network round-trip | Zero (localhost MCP) |
| Data privacy | Trust the server operator | Data never leaves the machine |
| IP protection | Behind API (can be intercepted, leaked) | Compiled Rust binary (machine code) |
| Server costs | Monthly hosting | Zero |
| Business model | Subscription forced | One-time purchase or annual license |
| Multi-device sync | Built-in | Git/iCloud/Dropbox (user choice) |
| Offline mode | Broken | Full functionality |
| Resource usage | N/A | ~10-30 MB RAM (Tauri is lightweight) |

The core argument: OverkillOS is a **local-first** tool. The brain lives in `~/.overkill/` and `.overkill/`. A SaaS product forces the architecture to fight its own design. A Tauri app preserves the local-first model and wraps it in a compiled binary that protects the IP.

---

## Architecture

```
┌───────────────────────────────────────────────────────┐
│                   OverkillOS Tauri App                 │
│                                                       │
│  ┌─────────────────────────────────────────────────┐  │
│  │  Rust Backend (compiled binary -- IP protected) │  │
│  │                                                 │  │
│  │  ┌──────────────┐  ┌────────────────────────┐   │  │
│  │  │ Memory       │  │ Bootstrap              │   │  │
│  │  │ Cascade      │  │ State Machine          │   │  │
│  │  │ Engine       │  │ (3-fork protocol)      │   │  │
│  │  └──────────────┘  └────────────────────────┘   │  │
│  │                                                 │  │
│  │  ┌──────────────┐  ┌────────────────────────┐   │  │
│  │  │ Write        │  │ Verification           │   │  │
│  │  │ Trigger      │  │ Engine                 │   │  │
│  │  │ Engine       │  │ (gates, no-regression) │   │  │
│  │  └──────────────┘  └────────────────────────┘   │  │
│  │                                                 │  │
│  │  ┌──────────────┐  ┌────────────────────────┐   │  │
│  │  │ PRD          │  │ Identity &             │   │  │
│  │  │ Pipeline     │  │ Global Brain           │   │  │
│  │  │ (4-pillar)   │  │ Manager                │   │  │
│  │  └──────────────┘  └────────────────────────┘   │  │
│  │                                                 │  │
│  │  ┌──────────────┐  ┌────────────────────────┐   │  │
│  │  │ Local MCP    │  │ File Encryption        │   │  │
│  │  │ Server       │  │ Layer                  │   │  │
│  │  │ (localhost)  │  │ (.overkill/ contents)  │   │  │
│  │  └──────────────┘  └────────────────────────┘   │  │
│  └─────────────────────────────────────────────────┘  │
│                                                       │
│  ┌─────────────────────────────────────────────────┐  │
│  │  Web Frontend (Tauri webview)                   │  │
│  │                                                 │  │
│  │  Dashboard · Memory Viewer · PRD Status         │  │
│  │  Verification Gates · Daily Logs · Settings     │  │
│  └─────────────────────────────────────────────────┘  │
│                                                       │
│  ┌─────────────────────────────────────────────────┐  │
│  │  System Tray                                    │  │
│  │  Active project · MCP status · Quick actions    │  │
│  └─────────────────────────────────────────────────┘  │
└───────────────────────────────────────────────────────┘

IDE connections (all via localhost MCP):
  Cursor ──────── localhost:7017 ──── Tauri MCP Server
  Claude Code ─── localhost:7017 ──── Tauri MCP Server
  OpenClaw ────── localhost:7017 ──── Tauri MCP Server
  Any MCP IDE ─── localhost:7017 ──── Tauri MCP Server
```

---

## Rust Backend Modules

### 1. Memory Cascade Engine (`src-tauri/src/memory/`)

Implements the three-tier cascade in compiled code:

- **Tier 1: QUICKSTART** -- ~300 token budget. Read every boot. Summary state.
- **Tier 2: MEMORY** -- ~2-5k token budget. Read on demand. Working memory.
- **Tier 3: ARCHIVE** -- Unlimited. Never pruned. Read by section anchor.

Functions:
- `cascade_read(project, tier)` -- returns computed context for the requested tier
- `cascade_write(project, tier, content)` -- writes and enforces size budgets
- `cascade_demote(project, from_tier)` -- moves oldest content down one tier
- `cascade_search(project, query)` -- semantic search across all tiers

Token budgets, demotion triggers, and section anchor formats are all internal. The agent never sees the rules -- it calls MCP tools and receives computed results.

### 2. Bootstrap State Machine (`src-tauri/src/bootstrap/`)

Three-fork detection logic:

```
Fork A: No ~/.overkill/ exists → first-ever install
         → UI-driven identity negotiation
         → create global brain
         → register project

Fork B: ~/.overkill/ exists, project NOT in registry → returning user, new project
         → skip identity (known from global brain)
         → register project
         → codebase due diligence (read-only audit)
         → PRD verification gate
         → user decision point

Fork C: ~/.overkill/ exists, project IN registry → returning user, known project
         → normal boot: return identity + QUICKSTART + daily logs
```

### 3. Write Trigger Engine (`src-tauri/src/triggers/`)

Event-based memory writes:

| Event | Action |
|-------|--------|
| Task completion | Write to daily log + update QUICKSTART if state changed |
| Significant decision | Write to MEMORY with rationale |
| Topic switch | Checkpoint current context to daily log |
| ~15 message exchanges | Automatic checkpoint to daily log |
| Session end | Update Live State Block + daily log + QUICKSTART |
| Context window >50% | Checkpoint warning + daily log write |
| Context window >80% | Force full checkpoint |

The Tauri app tracks message count and context estimates by monitoring MCP calls. When a trigger fires, it writes to the appropriate tier autonomously.

### 4. Verification Engine (`src-tauri/src/verification/`)

- Gate definitions (pass/fail, binary, no partial)
- No-regression policy enforcement
- Evidence row recording and validation
- Artifact contract verification (no artifact → no completion claim)
- Gate status dashboard data

### 5. PRD Pipeline (`src-tauri/src/prd/`)

- Four-pillar intake tracking (tech stack, competitors, features, target audience)
- PRD generation status per pillar (frontend, backend, database)
- Mid-production codebase audit workflow
- PRD verification gate (was the protocol executed?)

### 6. Global Brain Manager (`src-tauri/src/identity/`)

- Creates and manages `~/.overkill/` directory
- Handles IDENTITY.md, USER.md, SOUL-BASE.md, LEARNINGS.md
- Project registry (add, list, status, last-accessed)
- Cross-project learnings aggregation
- Encryption of sensitive identity files

### 7. Local MCP Server (`src-tauri/src/mcp/`)

Runs on `localhost:7017` (configurable). Exposes these tools to any connected IDE:

| MCP Tool | Purpose |
|----------|---------|
| `overkill_boot` | Called on first message. Returns identity + project context + recent memory. |
| `overkill_read` | Fetch deeper context (Tier 2, Tier 3, or specific section). |
| `overkill_write` | Record a memory entry (engine handles tier placement). |
| `overkill_gate` | Check or record a verification gate result. |
| `overkill_checkpoint` | Force a memory checkpoint (manual flush). |
| `overkill_prd_status` | Get PRD pipeline status for current project. |
| `overkill_project_list` | List all registered projects with status. |
| `overkill_search` | Semantic search across project memory. |

The MCP protocol means any IDE that supports MCP can connect. No IDE-specific plugins needed beyond the connection config.

### 8. File Encryption Layer (`src-tauri/src/crypto/`)

- Encrypts `.overkill/` and `~/.overkill/` file contents at rest
- Decrypted only by the running Tauri app
- Even if a user browses the directory, raw content is unreadable
- Key derived from license + machine-specific identifier
- Optional: user-provided passphrase for additional security

---

## Web Frontend (Dashboard)

Built with React/TypeScript (or Svelte -- decide during implementation). Rendered inside Tauri's native webview. NOT a web server -- no browser tab needed.

### Pages

**1. Home / Project Overview**
- All registered projects as cards
- Status badges (active, idle, needs attention)
- Last session date, current blockers, verification gate status
- Quick-switch to any project

**2. Memory Browser**
- Navigate QUICKSTART → MEMORY → ARCHIVE for any project
- Section anchors, search, filter by date
- Visual indicator of tier sizes vs budgets
- Daily log timeline with expandable entries

**3. PRD Dashboard**
- Four-pillar completion status per project
- Frontend/backend/database PRD generation progress
- Mid-production audit results
- Action items from PRD gaps

**4. Verification Gates**
- Gate status per phase per project
- Evidence rows with artifact links
- No-regression history
- Pass/fail trend over time

**5. Identity & Settings**
- Agent name, persona, personality sliders
- User profile editor
- Global brain contents viewer
- Cross-project learnings feed
- MCP server configuration (port, auto-start)
- License management
- Theme (light/dark)

**6. Onboarding Flow**
- License activation
- Identity setup (Fork A)
- First project registration
- IDE connection guide (auto-configure for Cursor)

---

## IDE Integration

### Cursor (Primary)

**Auto-configuration:** The Tauri app writes to `~/.cursor/mcp.json`:

```json
{
  "mcpServers": {
    "overkill": {
      "command": "npx",
      "args": ["-y", "@overkill-os/mcp-bridge"],
      "env": {
        "OVERKILL_PORT": "7017"
      }
    }
  }
}
```

Or direct stdio/SSE connection depending on Cursor's MCP transport at release time.

**AGENTS.md (simplified):** The project's `AGENTS.md` becomes minimal:

```markdown
# OverkillOS Agent

You are connected to OverkillOS via MCP tools. On your FIRST message in any
conversation, call `overkill_boot` to receive your identity, project context,
and recent memory. Do not manage .overkill/ files directly.

Available tools: overkill_boot, overkill_read, overkill_write, overkill_gate,
overkill_checkpoint, overkill_prd_status, overkill_search.

Core rules:
- No artifact, no completion claim.
- Call overkill_write after completing tasks, making decisions, or switching topics.
- Call overkill_gate before claiming any phase is complete.
- Call overkill_checkpoint every ~15 exchanges.
```

### Claude Code

Add to `.claude/settings.json`:

```json
{
  "mcpServers": {
    "overkill": {
      "url": "http://localhost:7017/mcp"
    }
  }
}
```

Same MCP tools, same behavior. No code changes needed.

### OpenClaw / Other MCP-Compatible IDEs

Same pattern. Point MCP config to `localhost:7017`. The agent receives the same tools regardless of IDE.

---

## Distribution

### macOS (Primary)

1. **Sign** the `.app` bundle with Apple Developer certificate
2. **Notarize** through Apple's notarization service (required for Gatekeeper)
3. **Package** as `.dmg` installer
4. **Distribute** via direct download from website (NOT Mac App Store)
   - Mac App Store sandboxing conflicts with writing to `~/.overkill/` and reading arbitrary project directories
   - Direct distribution gives full filesystem access

### Windows (Future)

- Tauri produces `.exe` (NSIS) and `.msi` (WiX) installers
- Code-sign with a Windows code signing certificate
- Distribute via website

### Linux (Future)

- Tauri produces `.AppImage`, `.deb`, `.rpm`
- Distribute via website and/or package managers

---

## Licensing & Revenue

### License Validation

- Use [Keygen.sh](https://keygen.sh/), [LemonSqueezy](https://www.lemonsqueezy.com/), or [Paddle](https://www.paddle.com/) for license key generation and validation
- First launch: user enters license key, app validates via HTTPS
- License token stored locally after activation
- Periodic re-validation (e.g. monthly) to prevent key sharing
- Grace period for offline use (e.g. 30 days without re-validation)

### Pricing Tiers

| Tier | Price | Features |
|------|-------|----------|
| **Indie** | $49 one-time (or $29/year) | 3 projects, basic memory cascade, single IDE |
| **Pro** | $99 one-time (or $59/year) | Unlimited projects, full cascade + PRD pipeline + verification, all IDEs |
| **Team** | $149/seat/year | Pro features + shared learnings across team members |

### What is Free vs Paid

The open-source markdown template (`init.sh` + `.overkill/` files) remains MIT-licensed and free forever. It is the reference implementation and personal tool.

The Tauri app adds:
- Compiled engine (no exposed rules)
- Dashboard UI
- File encryption
- Auto-configuration for IDEs
- MCP server (computed context vs raw file reads)
- License-gated features

---

## User Journey

### Acquisition

1. User visits overkill-os.dev (marketing site)
2. Reads about persistent agent memory, verification gates, auto-boot
3. Clicks "Download for macOS" → payment via LemonSqueezy/Paddle
4. Receives `.dmg` download link + license key via email

### Installation

5. Opens `.dmg`, drags OverkillOS to `/Applications`
6. Launches app for the first time

### Activation

7. License key entry screen
8. App validates key (requires internet, one time)
9. License stored locally

### Onboarding (Fork A -- first-ever)

10. Identity setup: name, work type, tech stack preferences, verification strictness
11. App creates `~/.overkill/` global brain with user's answers
12. First project registration: browse to project directory, select new/existing

### IDE Connection

13. "Connect to IDE" screen
14. For Cursor: "Auto-Configure" button writes MCP config
15. For others: copy-paste config snippet
16. Status indicator confirms MCP server is running and IDE is connected

### First Session

17. User opens project in Cursor
18. Types anything ("hey", "good morning", a task)
19. Agent calls `overkill_boot` via MCP
20. Tauri app returns computed context (identity + project state + recent memory)
21. Agent responds with full continuity -- knows user, knows project, knows recent work
22. Session proceeds normally; MCP tools handle all memory operations

### Ongoing Use

23. App runs in system tray (background, minimal resources)
24. MCP server always available on localhost
25. Dashboard accessible from tray icon any time
26. Memory, verification, and PRD state visible in dashboard
27. Agent writes checkpoints automatically via MCP triggers

---

## Development Phases

### Phase 1: Rust Core (Weeks 1-4)

Build the backend engine without any UI:

- [ ] Memory cascade engine (read, write, demote, search across 3 tiers)
- [ ] Bootstrap state machine (3-fork detection, identity flow)
- [ ] Global brain manager (create, read, update `~/.overkill/`)
- [ ] Per-project manager (create, read, update `.overkill/`)
- [ ] Write trigger engine (event detection, automatic checkpoints)
- [ ] File encryption layer (encrypt/decrypt `.overkill/` contents)
- [ ] MCP server (localhost, all 8 tools defined above)
- [ ] Integration tests: MCP tools return correct data for all 3 bootstrap forks

### Phase 2: Tauri Shell + Minimal UI (Weeks 5-6)

Wire the Rust backend into a Tauri app:

- [ ] Tauri project scaffolding (cargo tauri init)
- [ ] System tray with MCP status indicator
- [ ] License activation screen
- [ ] Onboarding flow (identity setup, first project registration)
- [ ] IDE connection screen with auto-configure for Cursor
- [ ] Minimal home page showing registered projects

### Phase 3: Dashboard (Weeks 7-9)

Build the full dashboard frontend:

- [ ] Project overview with status cards
- [ ] Memory browser (QUICKSTART → MEMORY → ARCHIVE navigation)
- [ ] Daily log timeline
- [ ] Verification gate status display
- [ ] PRD dashboard
- [ ] Identity and settings editor
- [ ] Theme support (light/dark)

### Phase 4: Polish + Distribution (Weeks 10-12)

- [ ] macOS code signing + notarization
- [ ] `.dmg` packaging
- [ ] License integration (Keygen/LemonSqueezy/Paddle)
- [ ] Marketing site (overkill-os.dev)
- [ ] Documentation site
- [ ] Beta testing with 3-5 users
- [ ] Performance profiling (memory usage, startup time, MCP response time)

### Phase 5: Launch

- [ ] Public release
- [ ] Product Hunt / Hacker News launch
- [ ] Windows + Linux builds (post-macOS stabilization)

---

## Technical Decisions (to resolve during Phase 1)

| Decision | Options | Leaning |
|----------|---------|---------|
| Frontend framework | React, Svelte, SolidJS | Svelte (smallest bundle, Tauri-native feel) |
| MCP transport | stdio, SSE, WebSocket | SSE (widest IDE compatibility) |
| Encryption algorithm | AES-256-GCM, ChaCha20-Poly1305 | ChaCha20-Poly1305 (faster on non-AES-NI hardware) |
| License provider | Keygen.sh, LemonSqueezy, Paddle | LemonSqueezy (simplest for solo dev) |
| Semantic search | Local embeddings, tantivy full-text | tantivy (no ML dependency, fast) |
| MCP port | Fixed 7017, dynamic | Fixed with user override in settings |
| Daily log format | Markdown, JSON | Markdown (human-readable if encryption is optional) |

---

## Relationship to File-Based Template

The open-source template (`init.sh` + markdown files) and the Tauri app coexist:

- **Template**: Free, MIT-licensed, fully functional. For users who want to manage their own files and customize everything. The "reference implementation."
- **Tauri app**: Paid product. Same underlying concepts, but the logic is compiled, files are encrypted, and the user gets a dashboard + MCP tools instead of raw markdown. The "product."

The Tauri app can optionally read existing `.overkill/` directories created by the template, providing an upgrade path. Users who outgrow the raw markdown files can install the app, point it at their projects, and it takes over management.

---

## IP Protection Summary

What the user CAN see:
- The dashboard UI (but cannot extract the source -- Tauri bundles it)
- MCP tool names and their inputs/outputs
- The simplified AGENTS.md in their project

What the user CANNOT see:
- Memory cascade logic (tier budgets, demotion rules, token counting)
- Bootstrap state machine (fork detection, transition conditions)
- Write trigger rules (event definitions, checkpoint thresholds)
- Verification engine internals (gate evaluation, regression detection)
- PRD pipeline logic (pillar completion rules, generation templates)
- File encryption keys and key derivation
- Cross-project learning algorithms

All of the above exists as compiled Rust machine code inside the application binary. Reverse-engineering a Rust binary is dramatically harder than reading a markdown file or intercepting an API response.
