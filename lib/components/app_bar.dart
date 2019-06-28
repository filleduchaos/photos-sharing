/*
 * Copyright 2019 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sharing_codelab/model/photos_library_api_model.dart';
import 'package:sharing_codelab/photos_library_api/album.dart';
import 'package:sharing_codelab/components/images.dart';
import 'package:sharing_codelab/components/menus.dart';
import 'package:sharing_codelab/components/thick_divider.dart';

class TripAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<PhotosLibraryApiModel>(
      builder:
          (BuildContext context, Widget child, PhotosLibraryApiModel apiModel) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AppBar(
            centerTitle: true,
            elevation: 0,
            title: const TrippaLogo(),
            bottom: const ThickDivider(),
            actions: [
              if (apiModel.isLoggedIn()) const AvatarMenu()
            ],
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 16);
}

class AlbumAppBar extends StatelessWidget {
  const AlbumAppBar({ this.album, this.onMenuSelect });

  final Album album;
  final void Function(BuildContext, AlbumMenuOptions) onMenuSelect;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'cover-${album.id}',
          child: CachedImage(
            album.coverPhotoBaseUrl,
            overlay: ImageOverlay.hard,
            showDefaultIf: album.isEmpty,
          ),
        ),
        centerTitle: true,
        title: Text(
          album.title ?? '[no title]',
          overflow: TextOverflow.fade,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        titlePadding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 16,
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      expandedHeight: MediaQuery.of(context).size.width / 1.4,
      brightness: Brightness.dark,
      backgroundColor: Theme.of(context).accentColor,
      pinned: true,
      actions: <Widget>[
        AlbumMenu(onSelect: onMenuSelect),
      ],
    );
  }
}

class TrippaLogo extends StatelessWidget {
  const TrippaLogo();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).accentColor;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          child: SvgPicture.asset(
            'assets/ic_fieldTrippa.svg',
            excludeFromSemantics: true,
            color: color,
          ),
          margin: const EdgeInsets.only(right: 8),
        ),
        Text(
          'Field Trippa',
          style: TextStyle(color: color),
        ),
      ],
    );
  }
}

AppBar plainAppBar() => AppBar(
  elevation: 0,
  iconTheme: const IconThemeData(color: Colors.white),
  backgroundColor: Colors.transparent,
  brightness: Brightness.dark,
);
