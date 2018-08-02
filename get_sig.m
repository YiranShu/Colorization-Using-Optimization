function [ sig, average ] = get_sig( window )

sig = var(window, 1);
if sig < 1e-6
    sig = 1e-6;
end
average = mean(window);

end

