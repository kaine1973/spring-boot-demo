
            <!-- Page Headings Start -->
            <div class="row justify-content-between align-items-center mb-10">

                <!-- Page Heading Start -->
                <div class="col-12 col-lg-auto mb-20">
                    <div class="page-heading">
                        <h3>Form <span>/ File Upload</span></h3>
                    </div>
                </div><!-- Page Heading End -->

            </div><!-- Page Headings End -->

            <div class="row">

                <!--FilePond Start-->
                <div class="col-12 mb-30">
                    <div class="box">
                        <div class="box-head">
                            <h3 class="title">FilePond</h3>
                        </div>
                        <div class="box-body">
                            <input class="file-pond" type="file" multiple>
                        </div>
                    </div>
                </div>
                <!--FilePond End-->

                <!--How To Use Start-->
                <div class="col-12 mb-30">
                    <div class="box">
                        <div class="box-head">
                            <h4 class="title">How To Use</h4>
                        </div>
                        <div class="box-body">
                            <h6>Basic Use HTML</h6>
                            <code>
                            &lt;input class="file-pond" type="file" multiple &gt;
                        </code>
                            <h6 class="mt-15">Js Activation</h6>
                            <code>
                            FilePond.registerPlugin(FilePondPluginImageExifOrientation, FilePondPluginImagePreview); <br>
                            const inputElement = document.querySelector('.file-pond'); <br>
                            const pond = FilePond.create( inputElement, { <br>
                                &nbsp;&nbsp;&nbsp;&nbsp;imagePreviewHeight: 140, <br>
                            });
                        </code>
                            <p class="mt-15">For more Information please follow the <a class="text-primary" href="https://pqina.nl/filepond/">Official Documentation</a></p>
                        </div>
                    </div>
                </div>
                <!--How To Use End-->

                <!--Dropify Start-->
                <div class="col-12 mb-30">
                    <div class="box">

                        <div class="box-head">
                            <h3 class="title">Dropify</h3>
                        </div>

                        <div class="box-body">
                            <div class="row mbn-20">

                                <!--Default Uploader Start-->
                                <div class="col-lg-6 col-12 mb-20">
                                    <h6 class="mb-15">Default Uploader</h6>
                                    <input class="dropify" type="file">
                                </div>
                                <!--Default Uploader End-->

                                <!--Preloaded File Start-->
                                <div class="col-lg-6 col-12 mb-20">
                                    <h6 class="mb-15">Preloaded File</h6>
                                    <input class="dropify" type="file" data-default-file="assets/images/error/error-2.png">
                                </div>
                                <!--Preloaded File End-->

                                <!--Custom Height Start-->
                                <div class="col-lg-6 col-12 mb-20">
                                    <h6 class="mb-15">Custom Height</h6>
                                    <input class="dropify" type="file" data-height="220">
                                </div>
                                <!--Custom Height End-->

                                <!--Disabled Start-->
                                <div class="col-lg-6 col-12 mb-20">
                                    <h6 class="mb-15">Disabled</h6>
                                    <input class="dropify" type="file" disabled>
                                </div>
                                <!--Disabled End-->

                            </div>
                        </div>

                    </div>
                </div>
                <!--Dropify End-->

                <!--How To Use Start-->
                <div class="col-12">
                    <div class="box">
                        <div class="box-head">
                            <h4 class="title">How To Use</h4>
                        </div>
                        <div class="box-body">
                            <h6>Basic Use HTML</h6>
                            <code>
                            &lt;input class="dropify" type="file" &gt;
                        </code>
                            <h6 class="mt-15">Js Activation</h6>
                            <code>
                            $('.dropify').dropify();
                        </code>
                            <p class="mt-15">For more Information please follow the <a class="text-primary" href="https://github.com/JeremyFagis/dropify">Official Documentation</a></p>
                        </div>
                    </div>
                </div>
                <!--How To Use End-->

            </div>
