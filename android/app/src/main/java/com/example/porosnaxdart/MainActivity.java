package com.example.porosnaxdart;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.v7.graphics.Palette;
import android.util.Log;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.BinaryCodec;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

import java.nio.ByteBuffer;
import java.util.Arrays;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL_PALETTE = "channel.palette";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        MethodChannel methodChannel = new MethodChannel(getFlutterView(), CHANNEL_PALETTE);
        methodChannel.setMethodCallHandler(new MethodChannel.MethodCallHandler() {
            @Override
            public void onMethodCall(MethodCall methodCall, final MethodChannel.Result result) {
                if (methodCall.method.equals("generate")) {
                    byte[] bytes = methodCall.argument("data");
                    Bitmap bitmap = BitmapFactory.decodeByteArray(bytes, 0, bytes.length);

                    Palette.from(bitmap).generate(new Palette.PaletteAsyncListener() {
                        @Override
                        public void onGenerated(@NonNull Palette palette) {
                            Log.d("PALETTE", "Result: " + palette.getVibrantColor(Color.BLACK));

                            result.success(palette.getVibrantColor(Color.BLACK));
                        }
                    });
                }
            }
        });
/*
        BasicMessageChannel<ByteBuffer> channel = new BasicMessageChannel<>(getFlutterView(), CHANNEL_PALETTE, BinaryCodec.INSTANCE);
        channel.setMessageHandler(new BasicMessageChannel.MessageHandler<ByteBuffer>() {
            @Override
            public void onMessage(ByteBuffer byteBuffer, final BasicMessageChannel.Reply<ByteBuffer> reply) {
                byte[] array = byteBuffer.array();

                Log.d("PALETTE", "Generating from: " + Arrays.toString(array));

                Bitmap bitmap = BitmapFactory.decodeByteArray(array, 0, array.length);

                Palette palette = Palette.from(bitmap).generate();
                ByteBuffer meh = (ByteBuffer) ByteBuffer.allocate(4).putInt(5).rewind();

                reply.reply(meh);
               *//* Palette.from(bitmap).generate(new Palette.PaletteAsyncListener() {
                    @Override
                    public void onGenerated(@NonNull Palette palette) {
                        ByteBuffer result = ByteBuffer.allocate(4);

                        result.putInt(palette.getVibrantColor(Color.BLACK));

                        ByteBuffer rewoundResult = (ByteBuffer) result.rewind();

                        Log.d("PALETTE", "Result: " + palette.getVibrantColor(Color.BLACK));
                        //Log.d("PALETTE", "Reply: " + Arrays.toString(result.array()));


                        ByteBuffer meh = (ByteBuffer) ByteBuffer.allocate(4).putInt(5).rewind();
                        reply.reply(meh);
                    }
                });*//*
            }
        });*/
    }
}
