close all; clear all; clc
%{
x=0:0.005:2*pi;
noiseX = awgn(x, 0.00011);
X(:,1)=(1+noiseX/100).*cos(x+noiseX);
X(:,2)=(1+noiseX/100).*sin(x+noiseX);
plot (X(:,1),X(:,2),'*')

P=(1/length(x))*(X'*X)
[v,e]=eigs(P,2)
axis equal
coff=pca(X)

%}
0.5*5+0.5*1
