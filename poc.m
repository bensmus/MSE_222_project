% each position is spaced out by 0.01 seconds
% everything is in base SI units

dt = 0.01;

% stationary marble in time
p_vect = [[0.01, 0.59]; [0.01, 0.59]];

% we hit it 
p_vect = [p_vect; hit(p_vect, 0.01, 2, dt)];

% then gravity turns on
p_vect = [p_vect; drop(p_vect, 0.5, dt)];

scatter(100 * p_vect(:, 1), 100 * p_vect(:, 2));

xlim([0, 60])
ylim([0, 60])

% these functions always return update mx2 position vector
function p_vect_update = hit(p_vect, m_marble, time_in_seconds, dt)

    % hits the marble with a 1N force 
    % in x direction over duration of 1 ms
    % impulse is 0.001 N*s
    % model this as velocity increase by 0.001/(m_marble)
    
    % in m/s
    v_vect = diff(p_vect);
    
    % initial position and velocity before hit
    p_o = p_vect(end, :);
    v_o = v_vect(end, :);
    
    v_o_new = v_o + [0.001 / m_marble, 0];
    
    v_vect_update = v_o_new + zeros(time_in_seconds * 1/dt, 2);
    
    % integrating with dt
    p_vect_update = p_o + cumsum(v_vect_update) * dt;
end


function p_vect_update = drop(p_vect, time_in_seconds, dt)
    
    % g = 9.81 m/(s^2) 
    
    v_vect = diff(p_vect);
    
    % initial position and velocity before drop
    p_o = p_vect(end, :);
    v_o = v_vect(end, :);
    
    a_vect_update = [0, -9.81] + zeros(time_in_seconds * 1/dt, 2);
    
    % integrating once
    v_vect_update = v_o + cumsum(a_vect_update) * dt;
    
    % integrating again
    p_vect_update = p_o + cumsum(v_vect_update) * dt;
end