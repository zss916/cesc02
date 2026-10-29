part of 'index.dart';

class MineView extends StatelessWidget {
  const MineView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: GetBuilder<MineLogic>(
        init: MineLogic(),
        builder: (logic) {
          return Column(
            children: [
              Divider(height: 12, color: Colors.transparent),
              // 头像大卡
              MineHeader(
                //intro: '- · -',
                name: logic.name,
                title: logic.userType,
                onTap: () {
                  // PageTools.toStack();
                  logic.onReady();
                },
              ),
              Divider(height: 18, color: Colors.transparent),
              // 菜单列表
              MineMenu(
                organization: logic.organization,
                authorization: logic.authSiteCount,
                notifyStatus: logic.isOpenNotify,
                version: AppInfo.appVersion,
                onOrganization: (value) {
                  logic.toOrganization(value);
                },
                onAuth: (value) {
                  logic.toAuth(value);
                },
                onNotify: () {
                  logic.toNotify();
                },
                onVersion: () {
                  logic.toVersion();
                },
              ),
              Divider(height: 24, color: Colors.transparent),
              // 退出登录
              LogoutButton(
                onLogout: () {
                  logic.toLogout();
                },
              ),

              Divider(height: 40, color: Colors.transparent),
            ],
          );
        },
      ),
    );
  }
}
