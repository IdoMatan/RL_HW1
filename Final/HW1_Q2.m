clc; close all;

% Word length (input)
K = 5;

language   = {'B', 'K', 'O', '-'};  % Given

pMat      = [ 0.1, 0.325, 0.25, 0.325    % Given
              0.4, 0,     0.4,  0.2
              0.2, 0.2,   0.2,  0.4
              0,   0,     0,    0 ];

% Initialize arrays:
    ProbableWord   = blanks(K);
    Pointer  = zeros(length(language), K + 1);   % Pointer array pointing to previous char (leading to current one)
    AccCost  = zeros(length(language), K + 1);   % state array of the best accumulated cost (price) of reaching state
    AccCost(1, 1) = 1;   % first layer, probability of 1 to "choose" B (index 1) - given
    
   
  % calculate for each state the most probable next state (and it's accumulated probability)  
    for ii = 2:K+1 
        TempPs = AccCost(:,ii-1).*pMat;
        [AccCost(:,ii), Pointer(:,ii)] = max(TempPs);
    end    
        
   % Reconstruct the best word recursivly
       [Probability,index] = max(AccCost(:,K+1));

   for kk = K+1:-1:2
       ProbableWord(kk) = language{Pointer(index,kk)};
       index = Pointer(index,kk);
   end   
   
       ProbableWord
       Probability
        
        