function carWashSimulator()
    num_bays = 3;
    % Generate Service Time Table for three wash bays
    S = serviceTimeTable(num_bays);
    
    % Generate Inter-Arrival Time Table for cars
    I = interArrivalTimeTable(6); % Generate table of inter-arrival time
    
    time = 0; % Initialize time
    
    while true
        numCars = floor(input('Number of cars => '));
        
        % Check for invalid input
        if (isempty(numCars) || numCars<1) 
            disp('INVALID NUMBER OF CARS. PLEASE TRY AGAIN')
            disp(' ');
        else
            disp(' ');
            break;
        end
    end
    
    % User input for type of generator
    while true
        disp('Choose the type of random number generator to be used:');
        disp('1. Normal Random Generator');
        disp('2. Linear Congruential Generator');
        disp('3. Uniform Distribution Random Generator');
        r = floor(input('Generator => '));
    
        % Check for invalid input
        if (isempty(r)==1 || r>3 || r<1)
            disp('INVALID INPUT. PLEASE TRY AGAIN')
            disp(' ');
        else
            disp(' ');
            break;
        end 
    end
    
    % Generate Random Numbers for Service Time, Inter-Arrival Time, and Arrival Time
    ST = randomNumberGenerator(r,numCars,100, num_bays); 
    IAT = randomNumberGenerator(r,numCars-1,100, num_bays);
    AT = randomNumberGenerator(r,numCars,30, num_bays);
    
    % Generate and print service type table
    generateAndPrintServiceTypeTable(numCars);
    
    % Call simulateAllCustomers with the correct arguments
    C = simulateAllCustomers(I, IAT, AT, 5, ST, S);
    
    % Print the simulation table
    printSimulationTable(C);
end
