import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 325,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildHeader(context),
          buildNavigationMenuItems(context),
        ],
      ),
    );
  }
}

Widget buildHeader(BuildContext context) {
  return /*FirebaseAuth.instance.currentUser!.isAnonymous
      ? Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Center(
              child: SizedBox(
                height: 15.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Click ",
                          style: TextStyle(fontSize: 16),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/login');
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 51, 96, 132)),
                            )),
                        const Text("or", style: TextStyle(fontSize: 16)),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed('/signup');
                            },
                            child: const Text(
                              "Register",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 51, 96, 132)),
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "to earn points and rewards",
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        )*/
      Container(
    ///////////////////////// WHEN USER IS LOGGED IN ////////////////////////////////

    padding: EdgeInsets.only(
      top: MediaQuery.of(context).padding.top,
    ),
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .13,
                  width: 180,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 82, 5, 0),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: const Text("IMAGE URL"),
                ),
                Container(
                  height: 50,
                  width: 100,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 0, 0, 0),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Admin/Employee/User",
                    ),
                  ),
                ),
              ]),
          const SizedBox(
            height: 12,
          ),
          const Text("Name",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          //const Padding(padding: EdgeInsets.all(2)),
          const Text("  Email"),
          const Padding(padding: EdgeInsets.all(5)),
        ],
      ),
    ),
  );
}

Widget buildNavigationMenuItems(BuildContext context) {
  return Flexible(
      child: SingleChildScrollView(
    child: Wrap(
      runSpacing: 0,
      children: [
        Card(
          child: ListTile(
              leading: const Icon(
                Icons.home_outlined,
                size: 24,
              ),
              title: const Text(
                "Home",
                style: TextStyle(fontSize: 18),
              ),
              onTap: () async {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/home', ModalRoute.withName('/home'));
              }),
        ),
        Card(
          child: ListTile(
              leading: const Icon(
                Icons.account_box_outlined,
                size: 24,
              ),
              title: const Text(
                "Profile",
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {}),
        ),
        Card(
          child: ListTile(
              leading: const Icon(
                Icons.favorite_border,
                size: 24,
              ),
              title: const Text(
                "Favorites",
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {}),
        ),
        Card(
          child: ListTile(
              leading: const Icon(
                Icons.notifications_none_outlined,
                size: 24,
              ),
              title: const Text(
                "Notifications",
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {}),
        ),
        Card(
          child: ListTile(
              leading: const Icon(
                Icons.article_outlined,
                size: 24,
              ),
              title: const Text(
                "Recipts",
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {}),
        ),
        const Divider(
          color: Colors.white54,
          thickness: 3,
        ),
        Card(
          child: ListTile(
              leading: const Icon(
                Icons.assignment_ind_outlined,
                size: 24,
              ),
              title: const Text(
                "Admin Panel",
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {
                Navigator.of(context).popAndPushNamed('/admin');
              }),
        ),
        Card(
          child: ListTile(
              leading: const Icon(
                Icons.settings_outlined,
                size: 24,
              ),
              title: const Text(
                "Settings",
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {}),
        ),
        Card(
          child: ListTile(
              leading: const Icon(Icons.help_center),
              title: const Text(
                "Help",
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {}),
        ),
        Card(
          child: ListTile(
            leading: const Icon(
              Icons.logout_outlined,
              size: 24,
            ),
            title: const Text(
              "Logout",
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {
              //FirebaseAuth.instance.signOut();
              //Navigator.of(context).popAndPushNamed('/');
            },
          ),
        )
      ],
    ),
  ));
}

Widget MenuTile(
  Icon icon,
) {
  return const ListTile();
}
