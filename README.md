# Jitterplot
These functions help drawing jitter plots in Makie.jl plotting system
# Use the functions as follows
```julia
using Pkg;
Pkg.add("https://github.com/4SAnalyticsnModelling/Jitterplot.git");
```
# Functions
```
jitterplot(x, y, width_jit; kwargs)

# width_jit (fraction between 0 and 1) determines the spread of scatter points
# kwargs are the keyword arguments same as Makie.jl scatter function


jitterplot!(x, y, width_jit; kwargs)

# for paired (dodged) jitter plots kwargs arguments must include 'dodge_group'
(a vector or an array of integers or floating point numbers)
# 'dodge_color' keyword provides a list of user defined colors for each each of the jitters
in a pair
# when 'dodge_color' is provided the 'color' keyword argument must not be included to avoid conflict
# the argument 'gap_jit' (fraction between 0 and 1; default value is 1.0 if not provided) controls the gap between paired jitters

```
# Examples
```julia
using Jitterplot;
using CairoMakie;

x = repeat(1:3, inner = 100);
y = repeat(rand(100), outer = 3);

jitterplot(x, y, 0.2)
```
<p align="center">
  <img src="assets/example1fig.png" width="600">
</p>

```julia
f = Figure();
ax = Axis(f[1, 1]);
jitterplot!(x, y, 0.2, color = :blue, markersize = 12, strokecolor = :black);
f
```
<p align="center">
  <img src="assets/example2fig.png" width="600">
</p>

```julia
dodge_group = repeat(1:2, outer =150);
dodge_color = [:blue, :green];
f = Figure();
ax = Axis(f[1, 1]);
jitterplot!(x, y, 0.1, gap_jit = 0.3, dodge_group = dodge_group, dodge_color = dodge_color, markersize = 12);
f
```
<p align="center">
  <img src="assets/example3fig.png" width="600">
</p>
