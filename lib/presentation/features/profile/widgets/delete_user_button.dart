import 'package:billsplit_flutter/presentation/features/delete_user_flow/delete_user_page.dart';
import 'package:flutter/material.dart';

class DeleteUserButton extends StatelessWidget {
  const DeleteUserButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).push(DeleteUserPage.route);
      },
      child: Text(
        "Delete User",
        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.red),
      ),
    );
  }
}
