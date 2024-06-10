function output = randomNumberGenerator(r, numCars, upper, num_bays) 
    R = zeros(num_bays, numCars);
    
    % Normal Random Generator
    if r == 1
        for bay = 1:num_bays
            R(bay, :) = round(rand(1, numCars) * (upper - 1) + 1);
        end
        
    % Linear Congruential Generator
    % Formula: X(i) = (a * X(i-1) + c) mod m
    elseif r == 2
        % use rand() to generate seed number (initial value)
        seed = round(rand() * 100);
        
        % Configure a, c, m
        m = 5; % Modulus (2^31)
        a = 10; % Multiplier
        c = 15; % Increment
        
        for bay = 1:num_bays
            R(bay, 1) = mod((a * seed + c), m);        
            for i = 2:numCars
                R(bay, i) = mod((a * R(bay, i - 1) + c), m);
            end
        
            % Map random number to the range of 1-upper
            R(bay, :) = mod(R(bay, :), upper) + 1;
        end
      
    % Uniform Distribution Random Generator
    % Formula: X(i) = a + R(i)(b-a)
    elseif r == 3        
        % Configure a, b and r
        a = 1; % min value
        b = upper; % max value 
        r = rand(num_bays, numCars); % random numbers as seed
        
        for bay = 1:num_bays
            for i = 1:numCars
                R(bay, i) = a + r(bay, i) * (b - a);
            end 
        end   
      
        % Round the random numbers to integers
        R = round(R);  
    end
    
    output = R;
end
