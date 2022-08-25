module JasonEpi

export chain_binomial_sim,sir_sim_infected, sird_sim
export cb_stan_sample, sird_stan_sample, StanCB
export sampled_plot,sampled_inc_plot

using Distributions
using MCMCChains
using StatsPlots

include("data-generation/simulate-cb-epidemic.jl")
include("data-generation/simulate-sir.jl")

include("stan-helper-functions/stan-samplers.jl")
include("stan-helper-functions/inc-draws-plot.jl")


"""
StanCB(stan model string, incidence, population)

Packs a stan model together in a similar way to Turing
"""
struct StanCB
    stan_string::String
    inc
    pop::Int64
end



end # module JasonEpi
