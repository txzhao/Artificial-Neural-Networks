epochs = 100;
neighbor = zeros(1, epochs);
for i = 1 : epochs
    neighbor(i) = round(6 * exp(-i/8));
end
plot(1 : epochs, neighbor)
xlabel('epoch');
ylabel('neighbor');