function generated_sound = generate_sound(frequencies)

    samples = 1920;
    t = linspace(0,0.04,samples);
    generated_sound = zeros(1,samples*length(frequencies)+500*length(frequencies));
    start = 1;
    final = samples;
    filter = .5*(1 - cos(2*pi*(1:samples)/(samples+1)));
    %for every frequency we will generate a short ultrasound
    for i = 1:length(frequencies)
       component = filter.*cos(2 * pi * frequencies(i) * t);
       generated_sound(start:final) = component;
       
       start = final+1+500;
       final = start + samples-1;
    end

end