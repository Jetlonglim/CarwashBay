function simulateCarArrival(ST, IAT, time, numCars, num_bays)
    % Initialize queue
    queue = zeros(1, num_bays);

    for carNumber = 1:numCars
        % Simulate car arrival
        fprintf('Arrival of car %d at minute %d\n', carNumber, time);

        % Check for available bays
        availableBays = find(queue == 0);

        if ~isempty(availableBays)
            % Service bay is available
            bay = availableBays(1);
            queue(bay) = 1; % Set the bay to occupied

            % Simulate service start
            fprintf('Service for car %d started at minute %d in bay %d\n', carNumber, time, bay);

            % Simulate service time
            serviceTime = ST(bay, carNumber);
            time = time + serviceTime;

            % Simulate service end
            fprintf('Service for car %d completed at minute %d\n', carNumber, time);

            % Release the bay
            queue(bay) = 0;
        else
            % All bays are occupied, car enters queue
            fprintf('Car %d entered the queue at minute %d\n', carNumber, time);

            % Simulate queue wait time
            queueWaitTime = sum(ST(:, carNumber)); % Total service time required by the car
            time = time + queueWaitTime; % Move time forward by the total wait time

            % Simulate service start after queue wait
            fprintf('Service for car %d started at minute %d from the queue\n', carNumber, time);

            % Simulate service time
            serviceTime = ST(1, carNumber); % Service time from the first bay
            time = time + serviceTime; % Move time forward by the service time

            % Simulate service end
            fprintf('Service for car %d completed at minute %d\n', carNumber, time);
        end

        % Simulate inter-arrival time
        if carNumber < numCars
            interArrivalTime = IAT(carNumber);
            time = time + interArrivalTime;
            fprintf('Arrival of car %d at minute %d\n', carNumber+1, time);
        end
    end
end
