close all;
clear all;

%% Generate FIR coefficients
b = fir1(34, 0.5, 'high',chebwin(35,30));
fs = 48000;
gap = 500;
size = 1920;
recObj = audiorecorder(fs,24,1);
trigger = audiorecorder(fs,24,1);
new_message = false;

while true
   
while ~new_message

    recordblocking(trigger,0.5);
    y = getaudiodata(trigger);
    s_filtered = highpass(y,18000,fs);
    peaks = findpeaks(abs(s_filtered));
    over_value = max(peaks)/12;
    counter = 0;
    for i = 1:length(peaks)
       if peaks(i) > over_value
           counter = counter + 1;
       else
           counter = 0;
           
       end
       
       if counter > 500
           disp('detected');
           new_message = true;
           close all;
           break;
       end
    end
   
end



% Waiting for sound

recordblocking(recObj, 2);

y = getaudiodata(recObj);

%plot(y);
figure;


%% Filter the sound

s_filtered = highpass(y,18000,fs);
    plot(s_filtered);
    title('Filtered sound');
    figure;
    
    %get the number of characters
    start = 1;  
    %{
N = length(s_filtered);
    maxim = max(s_filtered)/3;
    for poz = 1:N
        if s_filtered(poz) > maxim && start == 0 
            start = poz;
            break;
        end
    end
 %}
    peaks = findpeaks(abs(s_filtered));
    plot(peaks);
    over_value = max(peaks)/24;
    counter = 0;
    flag = 1;
    for i = 1:length(peaks)
       if peaks(i) > over_value
           counter = counter + 1;
           
           if flag == 1 
              start = i;
              flag = 0;
           end
       else
           counter = 0;
           start = i;
       end
       
       if counter > 200
           break;
       end
    end
    %start
     
    %length(peaks)
    start = start * 4.2;
   
    if (fix(start) + 8*(size+gap)) < length(s_filtered)
        [frequencies,last] = get_high_freq(s_filtered(fix(start):end),8,size,gap,fs);

        bits = get_bits(frequencies,7);
        no_words = bi2de(bits)

        [frequencies_msg,] = get_high_freq(s_filtered(fix(start)+8*(size+gap):end),no_words*2,size,gap,fs);
        mess = get_letters(frequencies_msg);
        disp(char(mess));

        
    end
    new_message = false;
    
end
