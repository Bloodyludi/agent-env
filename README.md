# agent-env

Reusable skillset layers and optional OMP configuration, loaded per project with direnv.

## Setup

Install `omp` and `direnv`, then clone this repository to the path expected by the layer loader:

```sh
git clone git@github.com:Bloodyludi/agent-env.git "$HOME/agent-env"
```

Enable the direnv hook in your shell. For zsh, add this to `~/.zshrc` and restart your shell:

```sh
eval "$(direnv hook zsh)"
```

## Skillset layers

Each directory under `layers/` is a named layer. Available layers:

| Layer | Skills |
| --- | --- |
| `golang` | Go development, tooling, and conventions |
| `planning` | Goal clarification and actionable plans |
| `eurorack` | Eurorack hardware design with atopile and KiCad |

To add a layer, use this structure:

```text
layers/my-layer/
├── config.yml                 # Optional OMP configuration overlay
└── .agents/skills/
    └── my-skill/
        └── SKILL.md
```

Each `SKILL.md` contains YAML frontmatter followed by instructions:

```markdown
---
name: my-skill
description: Explain when the agent should use this skill.
---

Instructions for the agent.
```

To install existing skills into a layer, run the skills CLI from that directory (requires Node.js/npm):

```sh
mkdir -p "$HOME/agent-env/layers/my-layer"
cd "$HOME/agent-env/layers/my-layer"
npx skills add samber/cc-skills-golang --agent pi
```

Replace `samber/cc-skills-golang` with the desired skill repository. `--agent pi` installs the selected skills into the directory's `.agents/skills/`, ready to load with `omp_use_layer my-layer`.

## Load layers via .envrc

Create a `.envrc` in the project that should use the layers:

```sh
source_up_if_exists
source_env "$HOME/agent-env/direnv/omp-layers.sh"

export OMP_PROFILE="work"

omp_use_layer planning
omp_use_layer golang
# omp_use_layer my-layer

omp_finish_layers
```

`source_up_if_exists` loads the nearest ancestor `.envrc` when present. Set `OMP_PROFILE` to the named OMP profile you want to use; it selects isolated authentication, settings, sessions, and caches.

Call `omp_use_layer` for each layer, then `omp_finish_layers` after selecting all layers.

Layers can bundle pi/OMP settings alongside skills. For example, `layers/planning/config.yml` could contain:

```yaml
defaultThinkingLevel: high
```

`omp_use_layer` appends each layer's optional `config.yml` to the colon-separated `PI_CONFIG_FILES`, preserving inherited entries. OMP merges these overlays over the active profile and project settings in call order:

- Later layers override conflicting settings from earlier layers; `golang` takes precedence over `planning` in the example above.
- Nested objects merge by key. Later scalar and array values replace earlier values.
- Explicit `omp --config` overlays load after `PI_CONFIG_FILES` and take precedence over layer configs.

See [OMP's configuration merge rules](https://github.com/can1357/oh-my-pi/blob/main/docs/settings.md#merge-rules).

The loader also collects skill paths in `OMP_SKILL_DIRS`. `omp_finish_layers` appends a cached overlay containing their combined `skills.customDirectories` list to `PI_CONFIG_FILES`, so this list takes precedence over earlier configs.

From the project directory, approve the `.envrc` and start OMP:

```sh
direnv allow
omp
```

Alternatively, whitelist trusted directory prefixes in `~/.config/direnv/direnv.toml` (or `$XDG_CONFIG_HOME/direnv/direnv.toml`):

```toml
[whitelist]
prefix = ["~/code/"]
```

Matching `.envrc` files and subsequent edits load automatically, so projects under `~/code/` can skip `direnv allow`.

For a launch that explicitly loads the directory environment, use `direnv exec . omp`. For Paseo, configure the [OMP launcher](bin/README.md).
