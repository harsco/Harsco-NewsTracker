#import <Foundation/Foundation.h>


@interface VZAnimatedView : UIView {
	CGRect drawingRect;
    BOOL isScreenDimmed;
    BOOL isAnimating;
}

@property CGRect drawingRect;
@property BOOL isScreenDimmed;
@property BOOL isAnimating;

+(id) animatedViewWithSuperView:(UIView *)aSuperview labelText:(NSString *)theText dimScreen:(BOOL)dimFlag;
-(void) dismissView;

@end
