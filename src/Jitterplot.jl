module Jitterplot
using CairoMakie
# A jitter function to randomly assign the x-axis positions for each x-parameter
function jitter(a, width_jit)
    a = Base.convert.(Float64, a)
    a .+= Base.rand(size(a)...) .* width_jit .- width_jit .* 0.5
    return a
end
# jitterplot! functions; kwargs are the same as the arguments in the scatter fuction of Makie.jl; dodge_group and dodge_color are the attributes for multiple dodged jitterplots; when dodge_color is assigned as one of the kwargs, the color argument in the kwargs does not apply.
function jitterplot!(x, y, width_jit :: Float64 = 0.2; kwargs...)
    if haskey(kwargs, :dodge_gap)
        dodge_gap = kwargs[:dodge_gap]
    else
        dodge_gap = 1.0
    end
    if (haskey(kwargs, :dodge_group) == true) & (haskey(kwargs, :dodge_color) == true)
        dodge_group = kwargs[:dodge_group]
        dodge_color = kwargs[:dodge_color]
        array0 = Array{Union{Float64, Int64}}(undef, 0 , 3)
        for (x, y, z) in zip(x, y, dodge_group)
            array1 = [x y z]
            array0 = vcat(array0, array1)
        end
        for (grp, grpl, dcolor) in zip(unique(dodge_group), 1:length(unique(dodge_group)), dodge_color)
            row_ind = findall(q -> (q .== grp), array0[:, 3])
            x = jitter((array0[row_ind, 1] .- 0.25 * dodge_gap) .+ 0.5 * dodge_gap * (grpl - 1)/(length(unique(dodge_group)) - 1), width_jit)
            y = array0[row_ind, 2]
            if haskey(kwargs, :direction)
                if kwargs[:direction] == :horizontal
                    Makie.scatter!(y, x, color = dcolor; kwargs...)
                else
                    Makie.scatter!(x, y, color = dcolor; kwargs...)
                end
            else
                Makie.scatter!(x, y, color = dcolor; kwargs...)
            end
        end
    elseif (haskey(kwargs, :dodge_group) == true) & (haskey(kwargs, :dodge_color) == false)
        dodge_group = kwargs[:dodge_group]
        array0 = Array{Union{Float64, Int64}}(undef, 0 , 3)
        for (x, y, z) in zip(x, y, dodge_group)
            array1 = [x y z]
            array0 = vcat(array0, array1)
        end
        for (grp, grpl) in zip(unique(dodge_group), 1:length(unique(dodge_group)))
            row_ind = findall(q -> (q .== grp), array0[:, 3])
            x = jitter((array0[row_ind, 1] .- 0.25 * dodge_gap) .+ 0.5 * dodge_gap * (grpl - 1)/(length(unique(dodge_group)) - 1), width_jit)
            y = array0[row_ind, 2]
            if haskey(kwargs, :direction)
                if kwargs[:direction] == :horizontal
                    Makie.scatter!(y, x; kwargs...)
                else
                    Makie.scatter!(x, y; kwargs...)
                end
            else
                Makie.scatter!(x, y; kwargs...)
            end
        end
    else
        x = jitter(x, width_jit)
        if haskey(kwargs, :direction)
            if kwargs[:direction] == :horizontal
                Makie.scatter!(y, x; kwargs...)
            else
                Makie.scatter!(x, y; kwargs...)
            end
        else
            Makie.scatter!(x, y; kwargs...)
        end
    end
end
# jitterplot function; not applicable for multiple dodged jitterplots.
function jitterplot(x, y, width_jit :: Float64; kwargs...)
    x = jitter(x, width_jit)
    if haskey(kwargs, :direction)
        if kwargs[:direction] == :horizontal
            Makie.scatter(y, x; kwargs...)
        else
            Makie.scatter(x, y; kwargs...)
        end
    else
        Makie.scatter(x, y; kwargs...)
    end
end
end
