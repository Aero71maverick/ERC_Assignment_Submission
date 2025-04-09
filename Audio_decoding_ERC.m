t = 0:1/fs:((length(data)-1)/fs);
figure(1)
plot(t,data);title("raw signal")
product_signal_by_coherennce_method = data.*sin(2*pi*10000*t')
figure(2)
plot(t,product_signal_by_coherennce_method);title("coherent signal")
messge_signal_unfiltered = half_of_message_signal*2
figure(3)
plot(t,messge_signal_unfiltered);title("final signal")
audiowrite("filtered_audio.wav",message_signal_filtered,fs)