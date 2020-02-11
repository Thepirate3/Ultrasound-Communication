function [frequencies,last]= get_high_freq(sound,no_freq,size,gap,fs)

final = size;
start = 1;
frequencies = zeros(1,no_freq);
for i = 1:no_freq
    
    fix = linspace(0,fs,size);
    y = fft(sound(start:final));
    [~,loc] = max(abs(y));
    FREQ_ESTIMATE = fix(loc);
   
    frequencies(i) = FREQ_ESTIMATE;
    start = final+gap+1;
    final = start + size-1;
    if start > length(sound) || final > length(sound)
       break; 
    end
end
    last = start;
end