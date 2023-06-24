function output = DNN(w12,w23, input)

% input is sequence of size N \

%output size =3
%ouput(1) = kp
%output(2) = ki
%output(3) = kd

%layers =1
%neurons =5

%weights size w12= 5x3
%             w23 =3x5

% i1 = e[k]
% i2 =e[k-1]
% i3 = e[k-2]

    alpha =0.1;
    lrc =0.1;           %nita
    N= length(input);   %length = 
    dw23 = 0;
    dw12 = 0;
    for k = 3:N        %k = 3,4,5.... N

        i1 = input(k);
        i2 = input(k-1);
        i3 = input(k-2);

        input_layer = [i1,i2,i3]' ; %[3x1]

        hiddenlayer_in = w12*input_layer;
        %        [5x1] = [5x3]*[3x1]
        hiddenlayer_out = tanh(hiddenlayer_in);
        % [5x1]

        output = w23*hiddenlayer_out;  %
        %[3x1] = [3x5]*[5x1]

        delta1 = input_layer(1)*(input_layer(1) -input_layer(2));
        delta2 = input_layer(1)*input_layer(1);
        delta3 = input_layer(1)*(input_layer(1) - 2*input_layer(2) + input_layer(3));
        delta_O3 = [delta1 , delta2, delta3]';
        %[3x1]

        dw23 = lrc*delta_O3*hiddenlayer_out' + alpha*dw23;
        %[3x5] = c*[3x1]*[1x5] + c*[3x5]
        w23 = w23+ dw23;
        %[3x5] = [3x5]+ [3x5]



        delta_O2 = (sech(hiddenlayer_in).^2).*(delta_O3*w23')';
        % [5x1]  = [5x1]*[[1x3]*[3x5]]'
        % [5x1]  = [5x1]*.[5x1]
        dw12 = lrc*input_layer*delta_O2' + alpha*dw12;
        %[5x3]= c*[3x1]*[1x5] + C*dw12
        w12 = w12+ dw12;
        % [5x3] = [5x3] 


    end


end