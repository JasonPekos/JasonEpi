"""Efficiently simulates a simple discrete chain binomial epidemic.

Initial incidence is drawn from a Binomial(population,0.03)

Returns incidence at each timestep / new infections, which is the same thing here. 
"""
function chain_binomial_sim(β::Float64, population::Int, process_len::Int)
    I = zeros(Int64, process_len)
    I[1] = rand(Binomial(population,0.03))
    for t in 2:process_len
        I[t] = rand(Binomial(population - sum(I[1:t-1]), -expm1(-β*I[t-1])))
    end
    return I
end

