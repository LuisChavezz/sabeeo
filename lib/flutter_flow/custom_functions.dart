import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/schema/structs/index.dart';
import '/auth/custom_auth/auth_util.dart';

List<dynamic> testArray() {
  return [
    {
      "name": "Notificación 1",
      "content": "Lorem ipsum y todo eso jeje :D",
      "created_at": '2021-01-01T00:00:00Z',
      "img":
          "https://res.cloudinary.com/dshn8thfr/image/upload/v1717101004/KinceIT%20-%20Mitosis%20-%20Comunicados/q3geoqp8ybmnypuye4s0.png"
    },
    {
      "name": "Notificación 2",
      "content":
          "Es simplemente el texto de relleno de las imprentas y archivos de texto.",
      "created_at": '2022-01-01T00:00:00Z',
      "img":
          "https://res.cloudinary.com/dshn8thfr/image/upload/v1717101004/KinceIT%20-%20Mitosis%20-%20Comunicados/elkxypwb4mtchgnl7im4.png"
    },
    {
      "name": "Notificación 3",
      "content":
          "Es un hecho establecido hace demasiado tiempo que un lector se distraerá con el contenido del texto de un sitio mientras que mira su diseño.",
      "created_at": '2023-11-03T00:00:00Z',
      "img":
          "https://res.cloudinary.com/dshn8thfr/image/upload/v1717101004/KinceIT%20-%20Mitosis%20-%20Comunicados/h1iamrih8ho65xxwtgzv.png"
    },
    {
      "name": "Notificación 4",
      "content":
          "No sólo sobrevivió 500 años, sino que tambien ingresó como texto de relleno en documentos electrónicos, quedando esencialmente igual al original.",
      "created_at": '2020-01-11T00:00:00Z',
      "img":
          "https://res.cloudinary.com/dshn8thfr/image/upload/v1717101003/KinceIT%20-%20Mitosis%20-%20Comunicados/tvoroawthgnvnnllclon.png"
    },
    {
      "name": "Notificación 5",
      "content":
          "Al contrario del pensamiento popular, el texto de Lorem Ipsum no es simplemente texto aleatorio.",
      "created_at": '2024-12-23T00:00:00Z',
      "img":
          "https://res.cloudinary.com/dshn8thfr/image/upload/v1717101003/KinceIT%20-%20Mitosis%20-%20Comunicados/iqpmsckddkbnxr5fmu7k.png"
    },
    {
      "name": "Notificación 6",
      "content":
          "Tiene sus raices en una pieza clásica de la literatura del Latin, que data del año 45 antes de Cristo.",
      "created_at": '2021-01-01T00:00:00Z',
      "img":
          "https://res.cloudinary.com/dshn8thfr/image/upload/v1717101003/KinceIT%20-%20Mitosis%20-%20Comunicados/gqx3dqe81jrfq3yt2yrd.jpg"
    },
    {
      "name": "Notificación 7",
      "content":
          "Si vas a utilizar un pasaje de Lorem Ipsum, necesitás estar seguro de que no hay nada avergonzante escondido en el medio del texto.",
      "created_at": '2023-01-01T00:00:00Z',
      "img":
          "https://res.cloudinary.com/dshn8thfr/image/upload/v1717101003/KinceIT%20-%20Mitosis%20-%20Comunicados/zgnplp08f41k361p6woy.jpg"
    },
  ];
}

String toCapitalize(String text) {
  return text[0].toUpperCase() + text.substring(1);
}
