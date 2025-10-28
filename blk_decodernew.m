function msgblk = blk_decoder(codeword)

% Compute syndrome bits using original index matrix
ind = [1 3 1 2;...
       2 4 3 4;...
       5 6 7 8 ];   
S = mod(sum(codeword(ind)),2);

% Initialize message block with first 4 bits
msgblk = codeword(1:4);

% Original syndrome calculation (kept for reference, can be uncommented if needed)
% S = zeros(1,4);
% S(1) = rem(sum(codeword([1 2 5])),2);
% S(2) = rem(sum(codeword([3 4 6])),2);
% S(3) = rem(sum(codeword([1 3 7])),2);
% S(4) = rem(sum(codeword([2 4 8])),2);

% Check for 1-bit errors using complete syndrome patterns (minimal modification)
if isequal(S, [1 0 1 0])    % Error in D1
    msgblk(1) = not(msgblk(1));
elseif isequal(S, [1 0 0 1]) % Error in D2
    msgblk(2) = not(msgblk(2));
elseif isequal(S, [0 1 1 0]) % Error in D3
    msgblk(3) = not(msgblk(3));
elseif isequal(S, [0 1 0 1]) % Error in D4
    msgblk(4) = not(msgblk(4));
end
% Note: Parity bit errors (other S patterns) require no correction to message bits
end