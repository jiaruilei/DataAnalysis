%% Create a temporary working folder to store the image sequence
workingDir = [pwd '\'];
all_videos = {'4Z4A8552_test'}; % file name of all videos
%% Image processing
for i = 1:1:length(all_videos)
    video_name = char(all_videos(i));
    mkdir(workingDir, [video_name '_images']); % create a folder to store processed images
    % Read the video
    video = VideoReader([video_name '.mov']); % read each video using VideoReader 
    video.CurrentTime = 5; % set the starting time
    ii = 1;
    while hasFrame(video) && ii <= 500     % Create the image sequence
        img = readFrame(video); % read a frame
        I = imcrop(img, [255.5 254.5 682 405]); % crop the frame
        I_1D = I(:,:,1); I = I_1D;
        [~, threshold] = edge(I, 'sobel'); % edge detection
        fudgeFactor = .5;
        BWs = edge(I,'sobel', threshold * fudgeFactor); 
        BWs_2 = bwareaopen(BWs, 30); % remove noise
        filename = [sprintf('%04d',ii) '.jpg'];
        fullname  = fullfile(workingDir, [video_name '_images'], filename);
        imwrite(BWs_2, fullname); % save the processed images
        ii = ii + 1;
    end
end
%% Stack mutiple images to show the range of motion
for i = 1:1:length(all_videos)
    running_average = 0;
    video_name = char(all_videos(i));
    imageNames = dir(fullfile(workingDir, [video_name '_images'], '\*.jpg'));
    imageNames = {imageNames.name}; % store the file name of all images in each folder
    for n = 1:1:100 % stack the first 100 images
        image_name = fullfile(workingDir, [video_name '_images'], imageNames(n));
        image_name = char(image_name);
        temp = imread(image_name);
        temp = double(temp);
        running_average = running_average + temp./10; 
    end
    running_average = uint8(running_average);
    figure(i);
    axis normal;
    imshow(running_average, 'border', 'tight');
    saveas(gcf,strcat(workingDir,[video_name '_2'],'.jpg')); % save as a .jpg image
end
