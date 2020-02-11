function [] = send_msg(message)
pause on;
fs = 48000;
notification_frequency = 19000;
samples = 3840*4;
t = linspace(0,0.32,samples);
generated_sound = zeros(1,samples);
start = 1;
final = samples;
filter = .5*(1 - cos(2*pi*(1:samples)/(samples+1)));
component = filter.*cos(2 * pi * 19000 * t);
generated_sound(start:end) = component;
%send notification for next message
sound(generated_sound,fs);
tic
time_to_sleep
toc
encoded_msg = encode_msg(message);
encoded_len = encode_msg_len(message);
sound(generate_sound([encoded_len encoded_msg]),fs);

end