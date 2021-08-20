using Jitterplot;

x = repeat(1:3, inner = 100);
y = repeat(rand(100), outer = 3);

# single jitterplot function example
jitterplot(x, y, 0.2)

# jitterplot functions in Makie.jl figure axes
x = repeat(1:3, inner = 100);
y = repeat(rand(100), outer = 3);

f = Makie.Figure();
ax = Makie.Axis(f[1, 1]);
jitterplot!(x, y, 0.2, color = :blue, markersize = 12);
f

# dodged multiple jitterplots
x = repeat(1:3, inner = 100);
y = repeat(rand(100), outer = 3);
dodge_group = repeat(1:4, outer =75);
dodge_color = [:red, :blue, :darkgreen, :cyan];

f = Makie.Figure();
ax = Makie.Axis(f[1, 1]);
jitterplot!(x, y, 0.2, dodge_group = dodge_group, dodge_color = dodge_color);
f
