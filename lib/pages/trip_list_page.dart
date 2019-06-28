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
import 'package:sharing_codelab/components/buttons.dart';
import 'package:sharing_codelab/components/create_trip_dialog.dart';
import 'package:sharing_codelab/components/join_trip_dialog.dart';
import 'package:sharing_codelab/components/app_bar.dart';
import 'package:sharing_codelab/components/trip_card.dart';
import 'package:sharing_codelab/pages/trip_page.dart';
import 'package:sharing_codelab/util/to_be_implemented.dart';

class TripListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TripAppBar(),
      body: ScopedModelDescendant<PhotosLibraryApiModel>(
        builder: (BuildContext context, Widget child,
            PhotosLibraryApiModel photosLibraryApi) {
          if (!photosLibraryApi.hasAlbums) {
            return Center(
              child: const CircularProgressIndicator(),
            );
          }

          if (photosLibraryApi.albums.isEmpty) {
            return const EmptyAlbumList();
          }

          return ListView.builder(
            itemCount: photosLibraryApi.albums.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return const TripAlbumButtons();
              }

              final album = photosLibraryApi.albums[index - 1];

              return TripCard(
                album: album,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => TripPage(
                      album: album,
                      searchResponse:
                          photosLibraryApi.searchMediaItems(album.id),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class EmptyAlbumList extends StatelessWidget {
  const EmptyAlbumList();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SvgPicture.asset(
          'assets/ic_fieldTrippa.svg',
          color: Theme.of(context).accentColor.withOpacity(.25),
          height: 148,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: Text(
            "You're not currently a member of any trip albums.",
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
        const TripAlbumButtons(),
      ],
    );
  }
}

class TripAlbumButtons extends StatelessWidget {
  const TripAlbumButtons();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          PrimaryRaisedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => const CreateTripDialog(),
              );
            },
            label: const Text('CREATE A TRIP ALBUM'),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              ' - OR - ',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SecondaryButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => const JoinTripDialog(),
              );
            },
            label: const Text('JOIN A TRIP ALBUM'),
          ),
        ],
      ),
    );
  }
}
