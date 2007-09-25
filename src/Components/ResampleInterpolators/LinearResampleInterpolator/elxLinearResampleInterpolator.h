#ifndef __elxLinearResampleInterpolator_h
#define __elxLinearResampleInterpolator_h

#include "itkLinearInterpolateImageFunction.h"
#include "elxIncludes.h"

namespace elastix
{
  using namespace itk;

  /**
  * \class LinearResampleInterpolator
  * \brief A linear resample-interpolator.
  *
  * Compared to the BSplineResampleInterpolator and BSplineResampleInterpolatorFloat 
  * with SplineOrder 1 this class uses less (in fact, no) memory. You can select
  * this resample interpolator if memory burden is an issue and linear interpolation
  * is sufficient.
  *
  * The parameters used in this class are:
  * \parameter ResampleInterpolator: Select this resample interpolator as follows:\n
  *   <tt>(ResampleInterpolator "FinalLinearInterpolator")</tt>
  *
  * \ingroup ResampleInterpolators
  */

  template < class TElastix >
  class LinearResampleInterpolator :
    public
    LinearInterpolateImageFunction<
    ITK_TYPENAME ResampleInterpolatorBase<TElastix>::InputImageType,
    ITK_TYPENAME ResampleInterpolatorBase<TElastix>::CoordRepType >,
    public ResampleInterpolatorBase<TElastix>
  {
  public:

    /** Standard ITK-stuff. */
    typedef LinearResampleInterpolator                              Self;
    typedef LinearInterpolateImageFunction<
      typename ResampleInterpolatorBase<TElastix>::InputImageType,
      typename ResampleInterpolatorBase<TElastix>::CoordRepType >   Superclass1;
    typedef ResampleInterpolatorBase<TElastix>                      Superclass2;
    typedef SmartPointer<Self>                                      Pointer;
    typedef SmartPointer<const Self>                                ConstPointer;

    /** Method for creation through the object factory. */
    itkNewMacro( Self );

    /** Run-time type information (and related methods). */
    itkTypeMacro( LinearResampleInterpolator, LinearInterpolateImageFunction );

    /** Name of this class.
    * Use this name in the parameter file to select this specific resample interpolator. \n
    * example: <tt>(ResampleInterpolator "FinalLinearInterpolator")</tt>\n
    */
    elxClassNameMacro( "FinalLinearInterpolator" );

    /** Dimension of the image. */
    itkStaticConstMacro( ImageDimension, unsigned int,Superclass1::ImageDimension );

    /** Typedef's inherited from the superclass. */
    typedef typename Superclass1::OutputType                OutputType;
    typedef typename Superclass1::InputImageType            InputImageType;
    typedef typename Superclass1::IndexType                 IndexType;
    typedef typename Superclass1::ContinuousIndexType       ContinuousIndexType;

    /** Typedef's from ResampleInterpolatorBase. */
    typedef typename Superclass2::ElastixType               ElastixType;
    typedef typename Superclass2::ElastixPointer            ElastixPointer;
    typedef typename Superclass2::ConfigurationType         ConfigurationType;
    typedef typename Superclass2::ConfigurationPointer      ConfigurationPointer;
    typedef typename Superclass2::RegistrationType          RegistrationType;
    typedef typename Superclass2::RegistrationPointer       RegistrationPointer;
    typedef typename Superclass2::ITKBaseType               ITKBaseType;

  protected:

    /** The constructor. */
    LinearResampleInterpolator() {}
    /** The destructor. */
    virtual ~LinearResampleInterpolator() {}

  private:

    /** The private constructor. */
    LinearResampleInterpolator( const Self& );  // purposely not implemented
    /** The private copy constructor. */
    void operator=( const Self& );              // purposely not implemented

  }; // end class LinearResampleInterpolator


} // end namespace elastix

#ifndef ITK_MANUAL_INSTANTIATION
#include "elxLinearResampleInterpolator.hxx"
#endif

#endif // end __elxLinearResampleInterpolator_h

