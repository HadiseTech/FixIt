import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_group_project/Features/Job/bloc/job_bloc.dart';
import 'package:flutter_group_project/Features/Job/bloc/job_state.dart';
import 'package:flutter_group_project/Features/Job/models/job.dart';
import 'package:flutter_group_project/Features/User/Model/User.dart' as models;
import 'package:flutter_group_project/Features/User/util/util.dart';
// import 'package:flutter_group_project/Features/User/Model/User.dart' as newUser;
import 'package:flutter_group_project/Users/NormalUser/JobDisplayScreen/userJobPageDetail.dart';

class UserJobMain extends StatelessWidget {
  static const routeName='/user/job';
  final userId = 2;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery
        .of(context)
        .size
        .width;
    final height = MediaQuery
        .of(context)
        .size
        .height;

    return FutureBuilder(
        future: this.getUserInfo() ,
        builder: (context,snapshot) {
        if(snapshot.hasData) {
        models.User user = snapshot.data;
        return BlocProvider.value(
          value: BlocProvider.of<JobBloc>(context),
          child: Scaffold(
            body: BlocBuilder<JobBloc, JobState>(
              builder: (_, state) {
                if (state is JobOperationFailure) {
                  return Text('Could not do job operation');
                }
                if (state is JobLoadingSuccess) {
                  List<Job> jobs = [];
                  final jobUser = state.jobs;
                  jobUser.forEach((element) {
                    if(element.userId == user.UserId){
                      jobs.add(element);
                    }
                  });
                  print("user Jobs: $jobUser");


                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: jobs.length,
                    itemBuilder: (_, idx) =>
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(
                                UserJobDetail.routeName, arguments: jobs[idx]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              child: new FittedBox(
                                child: Material(
                                  color: Colors.white,
                                  elevation: 14.0,
                                  borderRadius: BorderRadius.circular(24.0),
                                  shadowColor: Color(0x802196F3),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 16.0),
                                          child: myDetailsContainer1(
                                              jobs[idx].jobName,
                                              jobs[idx].location),
                                        ),
                                      ),
                                      SizedBox(width: 30,),
                                      Container(
                                        margin: EdgeInsets.only(top: 10, left: 50),
                                        width: width - 16,
                                        height: height * 0.3,
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius: new BorderRadius
                                                  .circular(24.0),
                                              child: CircleAvatar(
                                                radius: 50,
                                                backgroundImage: AssetImage(
                                                  // TODO: change this image path
                                                  'Assets/Images/me.jpg',

                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 15,),
                                            Text('${jobs[idx].user.fullName}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                  );
                }

                return Scaffold(
                  backgroundColor: Colors.white,
                  body: Center(child: CircularProgressIndicator(

                  ),),
                );
              },
            ),


          ),
        );
        }
        else{
          return Container();
        }
        }
    );
  }


  Widget myDetailsContainer1(String title, String location) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
            // TODO
              child: Text(
                "$title",
                style: TextStyle(
                    color: Color(0xffe6020a),
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              )),
        ),
        Container(
          // TODO
            child: Text(
              "$location",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            )),
      ],
    );
  }
  Future<models.User> getUserInfo() async{
    Util util= new Util();
    final user = await util.getUserInformation();
    return user;
  }

}
