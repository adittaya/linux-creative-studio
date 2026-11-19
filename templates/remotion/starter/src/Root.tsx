import React from 'react';
import { Composition } from 'remotion';
import { StudioSample } from './StudioSample';

export const RemotionRoot: React.FC = () => {
  return (
    <Composition
      id="StudioSample"
      component={StudioSample}
      durationInFrames={90}
      fps={30}
      width={1920}
      height={1080}
      defaultProps={{title: 'Linux Creative Studio', subtitle: 'Offline production', accent: '#5eead4'}}
    />
  );
};
