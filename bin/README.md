Paseo does not automatically evaluate a repository's .envrc before launching OMP.

### Tell Paseo to use the launcher

In `~/.paseo/config.json`, merge the following into your existing configuration:

```
{
  "agents": {
    "providers": {
      "omp": {
        "enabled": true,
        "command": [
          "/Users/YOUR_USER/agent-env/bin/omp-paseo"
        ]
      }
    }
  }
}
```

Replace `YOUR_USER` with your macOS username.

Then:
`paseo reload`

Start a new OMP agent in Paseo. Existing running agents won't automatically inherit the updated launch command. Paseo officially supports this binary override for its built-in OMP provider.
