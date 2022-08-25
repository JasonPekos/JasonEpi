using StatsPlots

function sampled_inc_plot(chain, data, num_plots)

    p = plot()
    
    p = plot(Array(chain[namesingroup(chain, :I)][1])[1,:],
             color = :blue,
             opacity = 0.1,
             label = "I, accepted samples",
             legend = :topleft );

    for i in 2:num_plots
        plot!(Array(chain[namesingroup(chain, :I)][i])[1,:],
              color = :blue, opacity = 0.1,
              label = "" )
    end
    plot!(data, color = 3, label = "")
    plot!(data, seriestype = :scatter, color = :cyan, label = "data")
    

    title!("Sampled Incidence Values")

    return p 
end

function sampled_plot(chain, data, num_plots, symbol, diff = "false")

    p = plot()
    if diff == "false"
        p = plot(Array(chain[namesingroup(chain, symbol)][1])[1,:],
                color = :blue,
                opacity = 0.1,
                label = "I, accepted samples",
                legend = :topleft );

        for i in 2:num_plots
            plot!(Array(chain[namesingroup(chain, symbol)][i])[1,:],
                color = :blue, opacity = 0.1,
                label = "" )
        end
    end
    if diff == "true"
        p = plot(diff(Array(chain[namesingroup(chain, symbol)][1])[1,:]),
                color = :blue,
                opacity = 0.1,
                label = "I, accepted samples",
                legend = :topleft );

        for i in 2:num_plots
            plot!(diff(Array(chain[namesingroup(chain, symbol)][i])[1,:]),
                color = :blue, opacity = 0.1,
                label = "" )
        end
    end
    plot!(data[2:end], color = 3, label = "")
    plot!(data[2:end], seriestype = :scatter, color = :cyan, label = "data")
    

    title!("Sampled Values")

    return p 
end