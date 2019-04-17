clear all; clc; 

%% Input
X = 800; N = 12;
%% Main
    global Dy_Phi
    Dy_Phi = zeros(X, N);
    Phi(X,N);

    Dy_Phi(X,N)
%% Counting function
    function [phi] = Phi(x,n)
    global Dy_Phi
    phi = 0;
      if (Dy_Phi(x,n) == 0 && (x >= n))      
              if ( x==n || n==1 )  
                  phi = 1;
              else
                  for i=1:x-1
                      phi = phi + (Phi(i,n-1));                 
                  end
              end
           Dy_Phi(x,n) = phi;
      else
          phi = Dy_Phi(x,n);
      end
    end
