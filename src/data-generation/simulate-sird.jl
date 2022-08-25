function pvec_euler_multinom(rates::Vector, dt::Real)
    probs = zeros(length(rates) + 1)
    probs[1] = exp(-sum(rates .* dt))
    if sum(rates) == 0
        return probs
    end
    for i = 2:length(probs)
        probs[i] = (rates[i-1] / sum(rates)) * (1 - exp(-sum(rates .* dt)))
    end
    return probs
end;


function sird_sim(β::Float64, γ::Float64, κ::Float64, population::Int, process_len::Int)
    S = zeros(Int64, process_len)
    I = zeros(Int64, process_len)
    R = zeros(Int64, process_len)
    D = zeros(Int64, process_len)
    deaths = zeros(Int64, process_len)

    I[1] = rand(Binomial(population,0.03))
    S[1] = population - I[1]
    R[1] = 0
    D[1] = 0
    deaths[1] = 0

    for t in 2:process_len
        new_infections = rand(Binomial(S[t-1], -expm1(-β*I[t-1] / population)))
        _, new_recoveries, new_deaths = rand(Multinomial(I[t-1], pvec_euler_multinom([γ, κ], 1)))
        I[t] = I[t-1] + new_infections - new_recoveries - new_deaths
        S[t] = S[t-1] - new_infections
        R[t] = R[t-1] + new_recoveries
        D[t] = D[t-1] + new_deaths
        deaths[t] = new_deaths

    end
    return (I = I, S = S, R = R, D = D, deaths = deaths)
end
