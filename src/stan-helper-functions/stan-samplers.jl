using StanSample

function cb_stan_sample(model, sampler = :NUTS, samples = 100, chains = 1)
    
    data_dict = Dict("numobs" => length(model.inc),
                 "obs" => model.inc,
                 "N" => model.pop,
                 "zerohack" => 0)

    # Compile model:
    cb = SampleModel("cb", model.stan_string)

    # Sample from model:
    chain = stan_sample(cb, data = data_dict, num_chains = chains)

    if success(chain)
        # Convert output to MCMC Chains object. 
        post_chain = read_samples(cb, :mcmcchains)
        names = namesingroup(post_chain, :I; index_type = :dot)
        nc = Dict(names[i] => Symbol(String(names[i])[1] *"["*  String(names[i])[3:end] * "]") for i in 1:length(names))
    
        out_chain = replacenames(post_chain,  nc)

        return out_chain
    end
    return "Failure during sampling"
end

function sird_stan_sample(model, sampler = :NUTS, samples = 1000, chains = 1)
    
    data_dict = Dict("numobs" => length(model.inc),
                 "obs" => model.inc,
                 "N" => model.pop,
                 "zerohack" => 0)

    # Compile model:
    cb = SampleModel("cb", model.stan_string)

    # Sample from model:
    chain = stan_sample(cb, data = data_dict, num_chains = chains)

    if success(chain)
        # Convert output to MCMC Chains object. 
        post_chain = read_samples(cb, :mcmcchains)

        # replace I
        names = namesingroup(post_chain, :I; index_type = :dot)
        nc = Dict(names[i] => Symbol(String(names[i])[1] *"["*  String(names[i])[3:end] * "]") for i in 1:length(names))
        out_chain = replacenames(post_chain,  nc)

        # replace D
        names = namesingroup(post_chain, :D; index_type = :dot)
        nc = Dict(names[i] => Symbol(String(names[i])[1] *"["*  String(names[i])[3:end] * "]") for i in 1:length(names))
        out_chain = replacenames(post_chain,  nc)

        # replace R
        names = namesingroup(post_chain, :R; index_type = :dot)
        nc = Dict(names[i] => Symbol(String(names[i])[1] *"["*  String(names[i])[3:end] * "]") for i in 1:length(names))
        out_chain = replacenames(post_chain,  nc)

        # replace S
        names = namesingroup(post_chain, :S; index_type = :dot)
        nc = Dict(names[i] => Symbol(String(names[i])[1] *"["*  String(names[i])[3:end] * "]") for i in 1:length(names))
        out_chain = replacenames(post_chain,  nc)
        
        return out_chain
    end
    return "Failure during sampling"
end


# function sir_stan_sample(model, sampler = :NUTS, samples = 100, chains = 1)
    
#     data_dict = Dict("numobs" => length(model.inc),
#                  "obs" => model.inc,
#                  "N" => model.pop,
#                  "zerohack" => 0)

#     # Compile model:
#     sir = SampleModel("sir", model.stan_string)

#     # Sample from model:
#     chain = stan_sample(sir, data = data_dict, num_chains = chains)

#     if success(chain)
#         # Convert output to MCMC Chains object. 
#         post_chain = read_samples(sir, :mcmcchains)
#         names = namesingroup(post_chain, :I; index_type = :dot)
#         nc = Dict(names[i] => Symbol(String(names[i])[1] *"["*  String(names[i])[3:end] * "]") for i in 1:length(names))
    
#         out_chain = replacenames(post_chain,  nc)

#         return out_chain
#     end
#     return "Failure during sampling"
# end
