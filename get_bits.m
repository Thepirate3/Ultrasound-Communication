function bits = get_bits(frequencies,no_frequnecies)
    bits = zeros(1,no_frequnecies);
    
    for i = 1:no_frequnecies
        diff = abs(frequencies(i) - frequencies(i+1));
        if diff > 400
            bits(i) = 1;
        elseif diff < 400 && diff > 200
            bits(i) = 0;
        elseif i == 1 && diff < 150
            bits(i) = 0;
            break;
        elseif diff < 150
            bits(i) = bits(i-1);
        end
    end
  
    
end