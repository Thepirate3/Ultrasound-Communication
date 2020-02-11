function letters = get_letters(frequencies)
    
   
    no_letters = length(frequencies);
    letters = zeros(1,no_letters/2);
    counter = 1;
    for i = 1:2:no_letters
        %extract major and minor digits from frequencies
        modulo = mod(frequencies(i),100);
        major = (frequencies(i) - (19000 + modulo)) /100;
        modulo = mod(frequencies(i+1),100);
        minor = (frequencies(i+1) - (19000 + modulo)) / 100;
        
        position = 10 * major + minor;
        letters(counter) = 45+position;
        counter = counter + 1;
    end
    
end