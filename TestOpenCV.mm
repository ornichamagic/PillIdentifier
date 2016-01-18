#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "Pill Identifier-Bridging-Header.h"

#import <opencv2/opencv.hpp>
#import <opencv2/highgui/ios.h>

@implementation TestOpenCV : NSObject

+(UIImage *)DetectEdgeWithImage:(UIImage *)image{
    
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
    
    return edgeImg;}


+(UIImage *)Gaussian:(UIImage *)image{
    
    cv::Mat m, gray;
    
    UIImageToMat(image, m);
    cv::cvtColor(m, gray, CV_RGBA2GRAY);
    cv::GaussianBlur(gray, gray, cv::Size(5, 5), 1.2, 1.2);
//    //cv::medianBlur(gray, gray, 2);
//    //cv::erode(gray, gray, cv::Mat(), cv::Point(-1,-1));
//    //cv::dilate(gray, gray, cv::Mat(), cv::Point(-1,-1));
//    cv::Canny(gray, gray, 0, 50);
//    //cv::dilate(edges, edges, cv::Mat(), cv::Point(-1,-1));
//    m = cv::Scalar::all(255);
//    m.setTo(cv::Scalar(0, 255, 255, 255), gray);
    
    UIImage *edgeImg = MatToUIImage(gray);
    
    return edgeImg;
}

@end