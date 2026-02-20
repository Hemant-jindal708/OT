v=[1 3 5];
%v(3)
m=[1 2 3;4 7 6;7 8 9];
b=[1 0 0;0 3 0;0 0 5];
%m/b
%m\b
x=[0:0.1:20];
y=sin(x);
z=cos(x);
plot(x,y);
hold on
plot(x, z);
xlabel('x');
ylabel('Function values');
legend('sin(x)', 'cos(x)');
title('Sine and Cosine Functions');
hold off;
x=[1:.1:10];
for i = 1:length(x)
    x(i)=x(i)+3;
end
fprintf("%.2f ",x);
x=5
if x==5
    disp('x is equal to 5');
end