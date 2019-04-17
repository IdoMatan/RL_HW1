clear all; clc

% Input
K = 5;

%% Definitions
languageCell        = {'B', 'K', 'O', '-'};
startingLetterIdx   = 1;
endingLetterIdx     = 4;
% since we are only considering a single word then we want there to be no
% transition probability from the end of word letter '-' to any other
% letter
pTransitionMat      = [ 0.1, 0.325, 0.25, 0.325;
                        0.4, 0    , 0.4 , 0.2  ;   
                        0.2, 0.2  , 0.2 , 0.4  ;
                        0  , 0    , 0   , 0   ]; % 0 probability to transtion out
%% Init
bestWord            = repmat('x', 1, K);
dynProgArrayWord    = zeros(length(languageCell), K + 1);
dynProgArrayCost    = zeros(length(languageCell), K + 1);
dynProgArrayCost(startingLetterIdx, 1) = 1;

%% Main
% Dynamic Programming
for kk = 2:(K + 1)
    curProbabilityMat = bsxfun(@times, pTransitionMat, dynProgArrayCost(:, kk - 1));
    [dynProgArrayCost(:, kk), dynProgArrayWord(:, kk)] = max(curProbabilityMat);
end

%% Reconstruct highest probability word
curLetterIdx = endingLetterIdx; % index of the of word letter
for kk = (K + 1):-1:2
    curLetterIdx        = dynProgArrayWord(curLetterIdx, kk);
    bestWord(kk - 1)    = languageCell{curLetterIdx};
end

%% Display Result
disp([bestWord, ' has the max probability which is ', num2str(dynProgArrayCost(endingLetterIdx, K + 1))]);





%% Question 2
% P=[0.5,0.125,0.25,0.125;0.4,0,0.4,0.2;0.2,0.2,0.2,0.4;1,0,0,0];
function [word] = mostProbableWord(K,P)
    C=log(1./P); % the updated cost funcion
    hist=[char('B'),char('K'),char('O')];
    charWord=zeros(1,K);
    Vk=inf(3,K); %1=b,2=k,3=o
    for stage=K:-1:1
        if stage==K %that means we are at the stage before '-'
            for letter=1:3
                Vk(letter,K)=C(letter,4);
            end
        elseif stage~=1 && stage~=K
            for letter=1:3
                Vk(letter,stage)=min(C(letter,1:3)+Vk(1:3,stage+1)');
        end
        else % means stage=1
            Vk(1,stage)=min(C(1,1:3)+Vk(1:3,stage+1)');
        %the other two letters in the first stage are ignored !
        end
    end
    charWord(1)=hist(1);
    for stage=2:K
        if stage==2
            [p,index]=min(C(1,1:3)+Vk(1:3,stage)');
            charWord(stage)=hist(index);
            prev_index=index;
        else
            [p,index]=min(C(prev_index,1:3)+Vk(1:3,stage)');
            charWord(stage)=hist(index);
            prev_index=index;
        end
    end
    word=string(charWord);
end