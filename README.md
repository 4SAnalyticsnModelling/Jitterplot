# Jitterplot
These functions help drawing jitter plots in Makie.jl plotting system
# Use the functions as follows
```julia
using Pkg;
Pkg.add("https://github.com/4SAnalyticsnModelling/Jitterplot.git");
```
# Example
```julia
using Jitterplot;
using CairoMakie;

x = repeat(1:3, inner = 100);
y = repeat(rand(100), outer = 3);

jitterplot(x, y, 0.2)
```
