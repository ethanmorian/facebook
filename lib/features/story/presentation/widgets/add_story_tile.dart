import 'package:facebook/core/constants/app_colors.dart';
import 'package:facebook/core/constants/constants.dart';
import 'package:facebook/features/story/presentation/screens/create_story_screen.dart';
import 'package:flutter/material.dart';

class AddStoryTile extends StatelessWidget {
  const AddStoryTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(CreateStoryScreen.routeName);
          },
          child: Container(
            color: AppColors.darkWhiteColor,
            height: 180,
            width: 100,
            child: Stack(
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: Image.network(
                    Constants.profilePicBlank,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                const Positioned(
                  top: 100,
                  left: 10,
                  right: 10,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: AppColors.blueColor,
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Positioned(
                  left: 10,
                  right: 10,
                  bottom: 5,
                  child: Column(
                    children: [
                      Text('Create'),
                      Text('Story'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
