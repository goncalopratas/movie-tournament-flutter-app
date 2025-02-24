import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/dependecy_injector.dart';
import '../presentation/cubit/movie_cubit.dart';
import 'bottom_sheet_item.dart';
import 'show_custom_dialog.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool hasMenu;
  final bool? hasAutomaticLeading;
  final VoidCallback? onLeadingTap;
  const CustomAppbar({
    super.key,
    required this.title,
    this.hasMenu = false,
    this.onLeadingTap,
    this.hasAutomaticLeading = false,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = getIt<MovieCubit>();
    return AppBar(
      title: Text(title),
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      leading: hasAutomaticLeading!
          ? IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                if (onLeadingTap != null) {
                  onLeadingTap!();
                } else {
                  context.pop();
                }
              },
            )
          : null,
      actions: [
        hasMenu
            ? IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Wrap(children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(32),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: double.maxFinite,
                                height: 40,
                                child: Text(
                                  'Escolha uma opção:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              BottomSheetItem(
                                  description: 'Pesquisar',
                                  onTap: () {
                                    context.push('/search');
                                  }),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Divider(height: 4),
                              ),
                              BottomSheetItem(
                                  description: 'Começar competição',
                                  onTap: () {
                                    if (cubit.state.savedList!.length != 8) {
                                      showCustomDialog(
                                        context,
                                        icon: Icons.error_outline,
                                        message:
                                            'Por favor escolha 8 filmes antes de iniciar a competição',
                                        onTap: () {
                                          context.pop();
                                        },
                                      );
                                    } else {
                                      context.push('/movieResults');
                                    }
                                  }),
                            ],
                          ),
                        ),
                      ]);
                    },
                  );
                },
              )
            : SizedBox(),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
