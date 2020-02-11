function encoded_msg = encode_msg(msg)
    
    N = length(msg);
    encoded_msg = zeros(1,2*N);
    counter = 1;
    for i = 1:N
        freq_code = double(msg(i)) - 45;
        major = fix(freq_code/10);
        minor = mod(freq_code,10);
        major_freq = 19000 + (major*100);
        minor_freq = 19000 + (minor*100);
        encoded_msg(counter:counter+1) = [major_freq minor_freq];
        counter = counter + 2;
    end
    
end