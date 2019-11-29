//
//  ViewController.m
//  ObjcStarter
//
//  Created by Nursultan on 21/11/2019.
//  Copyright © 2019 Nursultan. All rights reserved.
//

#import "ViewController.h"
#import "Course.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray<Course *> *courses;

@end

@implementation ViewController

NSString *cellId = @"cellId";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCourses];
    [self fetchCoursesUsingJSON];

    self.navigationItem.title = @"Courses";
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier: cellId];
}

- (void)fetchCoursesUsingJSON{
    NSLog(@"Fetching");
    
    NSString *urlString = @"https://api.letsbuildthatapp.com/jsondecodable/courses";
    NSURL *url = [NSURL URLWithString:urlString];
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"Finished fetching...");
        
//        NSString *dummyString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"dummy string: %@\n\n", dummyString);
        
        NSError *err;
        NSArray *courseJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        
        if (err) {
            NSLog(@"JSON serialization failed with error: %@", err.localizedDescription);
            return;
        }
        
        NSMutableArray<Course *> *courses = NSMutableArray.new;
        
        for (NSDictionary *courseDict in courseJSON) {
            NSString *name = courseDict[@"name"];
            NSNumber *numberOfLessons = courseDict[@"number_of_lessons"];
            Course *course = Course.new;
            course.name = name;
            course.numberOfLessons = numberOfLessons;
            [courses addObject:course];
        }
        
        NSLog(@"%@", courses);
        self.courses = courses;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
        
        
    }] resume];
}

- (void)setupCourses{
    self.courses = NSMutableArray.new;
    
    Course *course = Course.new;
    course.name = @"As-salamu 3alaikum";
    course.numberOfLessons = @(33);
    [self.courses addObject:course];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.courses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    Course *course = self.courses[indexPath.row];
    cell.textLabel.text = course.name;
    cell.detailTextLabel.text = [NSString stringWithFormat: @"Number of lessons: %@", course.numberOfLessons.stringValue];
    return cell;
}


@end
