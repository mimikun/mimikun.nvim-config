### Particle Settings

Options for configuring the particle generation and behavior.

#### Particle Opacity

```lua
vim.g.neovide_cursor_vfx_opacity = 200.0
```

Sets the transparency of the generated particles.

#### Particle Lifetime

```lua
vim.g.neovide_cursor_vfx_particle_lifetime = 0.5
vim.g.neovide_cursor_vfx_particle_highlight_lifetime = 0.2
```

Sets the amount of time the generated particles should survive.

`neovide_cursor_vfx_particle_highlight_lifetime` applies to `sonicboom`, `ripple` and `wireframe`, and the rest to `neovide_cursor_vfx_particle_lifetime`

If `neovide_cursor_vfx_particle_highlight_lifetime` is set to `0` then `neovide_cursor_vfx_particle_lifetime` is used.

#### Particle Density

```lua
vim.g.neovide_cursor_vfx_particle_density = 0.7
```

Sets the number of generated particles. 
The unit is the amount of particles per lines of travel.

#### Particle Speed

```lua
vim.g.neovide_cursor_vfx_particle_speed = 10.0
```

Sets the speed of particle movement in pixels / second.

#### Particle Phase

```lua
vim.g.neovide_cursor_vfx_particle_phase = 1.5
```

Only for the `railgun` vfx mode.

Sets the mass movement of particles, or how individual each one acts. 
The higher the value, the less particles rotate in accordance to each other, the lower, the more line-wise all particles become.

#### Particle Curl

```lua
vim.g.neovide_cursor_vfx_particle_curl = 1.0
```

Only for the `railgun` vfx mode.

Sets the velocity rotation speed of particles. 
The higher, the less particles actually move and look more "nervous", the lower, the more it looks like a collapsing sine wave.

