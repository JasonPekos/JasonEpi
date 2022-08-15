function sir_sim_infected(β::Float64, γ::Float64, population::Int, process_len::Int)
    S = zeros(Int64, process_len)
    I = zeros(Int64, process_len)
    R = zeros(Int64, process_len)
    I[1] = rand(Binomial(population,0.03))
    S[1] = population - I[1]
    R[1] = 0
    for t in 2:process_len
        new_infections = rand(Binomial(S[t-1], -expm1(-β*I[t-1] / population)))
        new_recoveries = rand(Binomial(I[t-1], -expm1(-γ)))
        I[t] = I[t-1] + new_infections - new_recoveries
        S[t] = S[t-1] - new_infections
        R[t] = R[t-1] + new_recoveries
    end
    return I
end