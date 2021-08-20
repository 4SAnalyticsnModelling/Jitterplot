cd(@__DIR__);
# using Jitterplot;
include("../src/Jitterplot.jl")
using CairoMakie;

x = repeat(1:3, inner = 100);
y = repeat(rand(100), outer = 3);

# single jitterplot function example
f = Jitterplot.jitterplot(x, y, 0.2)
Makie.save("../assets/example1fig.png", f);

# jitterplot functions in Makie.jl figure axes
x = repeat(1:3, inner = 100);
y = repeat(rand(100), outer = 3);

f = Makie.Figure();
ax = Makie.Axis(f[1, 1]);
Jitterplot.jitterplot!(x, y, 0.2, color = :blue, markersize = 12, strokecolor = :black);
f

Makie.save("../assets/example2fig.png", f);

# dodged multiple jitterplots
x = repeat(1:3, inner = 100);
y = repeat(rand(100), outer = 3);
dodge_group = repeat(1:2, outer =150);
dodge_color = [:blue, :green];

f = Makie.Figure();
ax = Makie.Axis(f[1, 1]);
jitterplot!(x, y, 0.1, gap_jit = 0.3, dodge_group = dodge_group, dodge_color = dodge_color, markersize = 12);
f
Makie.save("../assets/example3fig.png", f);
