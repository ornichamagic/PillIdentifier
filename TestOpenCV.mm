#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Pill Identifier-Bridging-Header.h"

#import <opencv2/opencv.hpp>
#import <opencv2/highgui/ios.h>

using namespace cv;
using namespace std;


@implementation TestOpenCV : NSObject

+(NSString *)DetectEdgeWithImage:(UIImage *)image{
    
    //UIImageをcv::Matに変換
    cv::Mat mat;
    UIImageToMat(image, mat);
    
    //白黒濃淡画像に変換
    cv::Mat gray;
    cv::cvtColor(mat, gray, CV_BGR2GRAY);
    
    //エッジ検出
    cv::Mat edge;
    cv::Canny(gray, edge, 200, 180);
    
    //cv::MatをUIImageに変換
    UIImage *edgeImg = MatToUIImage(edge);
    
    return @"AA";}


+(UIImage *)Gaussian:(UIImage *)image{
    
    Mat img0;
    UIImageToMat(image, img0);
    
    Mat img1;
    cvtColor(img0, img1, CV_RGB2GRAY);
    
    // apply your filter
    Canny(img1, img1, 100, 200);
    
    // find the contours
    vector< vector<cv::Point> > contours;
    findContours(img1, contours, CV_RETR_EXTERNAL, CV_CHAIN_APPROX_NONE);
    
    cout << " Area: " << contours.size() << endl;

    
    //cout << " Area: " << contourArea(contours[1]) << endl;
    
    // you could also reuse img1 here
    Mat HSV;
    Mat mask = Mat::zeros(img1.rows, img1.cols, CV_8UC1);
    int i = (img0.rows/2);
    int j = (img0.cols/2);
    
    Mat RGB=img0(cv::Rect(i,j,1,1));
    cvtColor(img0, HSV,CV_BGR2HSV);
    
    Vec3b hsv=HSV.at<Vec3b>(i,j);
  
    
    
    //sprintf(name,"H=%d",H);
    putText(HSV,".", cv::Point(i,j) , FONT_HERSHEY_SIMPLEX, .7, Scalar(0,255,0), 2,8,false );
    
    UIImage *edgeImg = MatToUIImage(HSV);

    
    return edgeImg;
}

+(NSString *)DetectColor:(UIImage *)image{
    NSString *color;
    Mat img0;
    UIImageToMat(image, img0);
    
    Mat img1;
    cvtColor(img0, img1, CV_RGB2GRAY);
    
    // apply your filter
    Canny(img1, img1, 100, 200);
    
    // find the contours
    vector< vector<cv::Point> > contours;
    findContours(img1, contours, CV_RETR_EXTERNAL, CV_CHAIN_APPROX_NONE);
    
    //cout << " Area: " << contourArea(contours[1]) << endl;
    
    // you could also reuse img1 here
    Mat mask = Mat::zeros(img1.rows, img1.cols, CV_8UC1);
    
    // CV_FILLED fills the connected components found
    drawContours(mask, contours, -1, Scalar(255), CV_FILLED);
    
    
    /*
     Before drawing all contours you could also decide
     to only draw the contour of the largest connected component
     found. Here's some commented out code how to do that:
     */
    
    //    vector<double> areas(contours.size());
    //    for(int i = 0; i < contours.size(); i++)
    //        areas[i] = contourArea(Mat(contours[i]));
    //    double max;
    //    Point maxPosition;
    //    minMaxLoc(Mat(areas),0,&max,0,&maxPosition);
    //    drawContours(mask, contours, maxPosition.y, Scalar(1), CV_FILLED);
    
    // let's create a new image now
    Mat crop(img0.rows, img0.cols, CV_8UC3);
    
    // set background to green
    crop.setTo(Scalar(255,255,255));
    
    // and copy the magic apple
    img0.copyTo(crop, mask);
    
    // normalize so imwrite(...)/imshow(...) shows the mask correctly!
    normalize(mask.clone(), mask, 0.0, 255.0, CV_MINMAX, CV_8UC1);
    
 
    
    //        for (int i = 0; i < mask.rows; i++)
    //        {
    //            for (int j = 0; j < mask.cols; j++)
    //            {
    //
    //
    //    Vec3b rgb=img0.at<Vec3b>(i,j);
    //    int B=rgb.val[0];
    //    int G=rgb.val[1];
    //    int R=rgb.val[2];
    //
    Mat HSV;
    //
    char name[30];
    
    int i = (img0.rows/2);
    int j = (img0.cols/2);
    
//    int i = 100;
//    int j = 100;
    
    cout << " i: " << i << endl;
    cout << " j: " << j << endl;
    
    
    Mat RGB=img0(cv::Rect(i,j,1,1));
    cvtColor(img0, HSV,CV_BGR2HSV);
    
    Vec3b hsv=HSV.at<Vec3b>(i,j);
    int H=hsv.val[0];
    int S=hsv.val[1];
    int V=hsv.val[2];
    
    cout << " H: " << H << endl;
    cout << " S: " << S << endl;
    cout << " V: " << V << endl;
    
    if(V == 0)
    {
        color = @"White";
    }
    else  if( S == 0)
    {
        color = @"Black";
    }
    
    else if (H >= 0 && H <= 3)
    {
        color = @" Red";
    }
    else if (H >= 4 && H <= 10)
    {
        color = @"Red-Orange";
    }
    else if (H >= 11 && H <= 12 )
    {
        color = @"Orange";
    }
    else if (H >= 13 && H <= 20)
    {
        color = @"Orange-Brown";
    }
    else if (H >= 21 && H <= 25)
    {
        color = @"Orange-Yellow";
    }
    else if (H >= 26 && H <= 30)
    {
        color = @"Yellow";
    }
    else if (H >= 31 && H <= 40)
    {
        color = @"Yellow-Green";
    }
    else if (H >= 41 && H <= 70)
    {
        color = @"Green";
    }
    else if (H >= 71 && H <= 85)
    {
        color = @"Green-Cyan";
    }
    else if (H >= 86 && H <= 100)
    {
        color = @"Cyan";
    }
    else if (H >= 101 && H <= 110)
    {
       color = @"Cyan-Blue";
    }
    else if (H >= 111 && H <= 130)
    {
        color = @"Blue";
    }
    else if (H >= 131 && H <= 140)
    {
        color = @"Violet";
    }
    else if (H >= 141 && H <= 160)
    {
        color = @"Magenta";
    }
    else if (H >= 161 && H <= 167)
    {
        color = @"Magenta-Pink";
    }
    else if (H >= 168 && H <= 175)
    {
        color = @"Pink";
    }
    else if (H >= 176 && H <= 177)
    {
        color = @"Pink-Red";
    }
    else if (H >= 176 && H <= 177)
    {
        color = @"Pink-Red";
    }
    else if (H >= 178 && H <= 180)
    {
        color = @"Red";
    }
    

    return color;
}

+(NSString *)DetectArea:(UIImage *)image{
    
    NSString *Area;
    Mat img0;
    UIImageToMat(image, img0);
    
    Mat img1;
    cvtColor(img0, img1, CV_RGB2GRAY);
    
    // apply your filter
    Canny(img1, img1, 100, 200);
    
    // find the contours
    vector< vector<cv::Point> > contours;
    findContours(img1, contours, CV_RETR_EXTERNAL, CV_CHAIN_APPROX_NONE);
    

    
    
        int precision = 10;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.minimumFractionDigits = precision;
    formatter.maximumFractionDigits = precision;
   Area = [formatter stringFromNumber:@(contourArea(contours[0]))];
    
    
    
   
    //cout << " Area: " << contourArea(contours[1]) << endl;
    
    // you could also reuse img1 here
    Mat mask = Mat::zeros(img1.rows, img1.cols, CV_8UC1);
    
    // CV_FILLED fills the connected components found
    drawContours(mask, contours, -1, Scalar(255), CV_FILLED);
    
    
    // let's create a new image now
    Mat crop(img0.rows, img0.cols, CV_8UC3);
    
    // set background to green
    crop.setTo(Scalar(255,255,255));
    
    // and copy the magic apple
    img0.copyTo(crop, mask);
    
    // normalize so imwrite(...)/imshow(...) shows the mask correctly!
    normalize(mask.clone(), mask, 0.0, 255.0, CV_MINMAX, CV_8UC1);

    
  
    Mat HSV;
    //
    
    int i = (img0.rows/2);
    int j = (img0.cols/2);
    
    cout << " i: " << i << endl;
    cout << " j: " << j << endl;
    
    
    //Mat RGB=img0(cv::Rect(i,j,1,1));
    cvtColor(img0, HSV,CV_BGR2HSV);
    
    Vec3b hsv=HSV.at<Vec3b>(i,j);
    int H=hsv.val[0];
    int S=hsv.val[1];
    int V=hsv.val[2];
    
//    cout << " H: " << H << endl;
//    cout << " S: " << S << endl;
//    cout << " V: " << V << endl;
    
    
    
    return Area;



  
}

@end