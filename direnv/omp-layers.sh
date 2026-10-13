omp_use_layer() {
  local root="$HOME/agent-env/layers/$1"

  [[ -d "$root" ]] || {
    echo "Unknown OMP layer: $1" >&2
    return 1
  }

  # Optional configuration
  if [[ -f "$root/config.yml" ]]; then
    watch_file "$root/config.yml"
    export PI_CONFIG_FILES="${PI_CONFIG_FILES:+$PI_CONFIG_FILES:}$root/config.yml"
  fi

  # Optional skills
  if [[ -d "$root/.agents/skills" ]]; then
    export OMP_SKILL_DIRS="${OMP_SKILL_DIRS:+$OMP_SKILL_DIRS:}$root/.agents/skills"
  fi
}

omp_finish_layers() {
  [[ -n "${OMP_SKILL_DIRS:-}" ]] || return 0

  local cache="${XDG_CACHE_HOME:-$HOME/.cache}/omp/layers"
  local key file tmp dir
  local dirs=()

  mkdir -p "$cache"

  key=$(printf '%s' "$OMP_SKILL_DIRS" | shasum -a 256 | cut -c1-20)
  file="$cache/$key.yml"

  if [[ ! -f "$file" ]]; then
    tmp=$(mktemp "$cache/.tmp.XXXXXX") || return 1

    IFS=: read -r -a dirs <<< "$OMP_SKILL_DIRS"

    {
      printf 'skills:\n  customDirectories:\n'
      for dir in "${dirs[@]}"; do
        printf '    - "%s"\n' "$dir"
      done
    } > "$tmp"

    mv "$tmp" "$file"
  fi

  export PI_CONFIG_FILES="${PI_CONFIG_FILES:+$PI_CONFIG_FILES:}$file"
}